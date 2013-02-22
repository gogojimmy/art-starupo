require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'capistrano_colors'
require "delayed/recipes"
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"

set :rvm_ruby_string, 'ruby-1.9.3-p194'

set :application, "startupo"
set :repository,  "git@github.com:gogojimmy/art-starupo.git"

set :scm, :git
set :scm_verbose, true
set :use_sudo, false

set :stages, %(staging production)
set :default_stage, "production"
set :rails_env, "production" #added for delayed job

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :custom_setup, :roles => [:app] do
    run "cp #{shared_path}/config/*.yml #{release_path}/config/"
  end

  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
  task :reset_db do
    run "cd #{current_path}; rake db:reset RAILS_ENV=#{rails_env}"
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run_locally "bundle exec rake assets:precompile"
        find_servers_for_task(current_task).each do |server|
          run_locally "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{server.host}:#{shared_path}/"
        end
        run_locally "rm -rf public/assets/*"
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

task :tail_log, :roles => :app do
  run "tail -f #{shared_path}/log/#{rails_env}.log"
end

namespace :mysql do
  task :sync do ; end

  task :backup, :roles => :db, :only => { :primary => true } do
    run "mkdir -p #{shared_path}/backup"
    filename = "#{shared_path}/backup/#{application}.sql"
    text = capture "cat #{deploy_to}/current/config/database.yml"
    yaml = YAML::load(text)

    on_rollback { run "rm #{filename}" }
    run "mysqldump -u #{yaml[rails_env]['username']} -p #{yaml[rails_env]['database']} > #{filename}" do |ch, stream, out|
      ch.send_data "#{yaml[rails_env]['password']}\n" if out =~ /^Enter password:/
    end
  end

  task :import do
    config = YAML.load_file("config/database.yml")["development"]
    username, password, database = config.values_at *%w( username password database )

    remote_file = "#{shared_path}/backup/#{application}.sql"
    local_filename = "mysql_backup/#{application}.sql"

    run_locally "mkdir -p mysql_backup"
    get "#{remote_file}", local_filename

    mysql_cmd = "mysql -u#{username}"
    mysql_cmd += " -p#{password}" if password
    `#{mysql_cmd} -e "drop database #{database}; create database #{database}"`
    `#{mysql_cmd} #{database} < #{local_filename}`
  end
end

before "deploy:assets:precompile", "deploy:custom_setup"
before 'deploy:setup', 'rvm:install_rvm'
after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"
after "deploy:migrations", "deploy:generate_yard"
after "mysql:sync", "mysql:backup", "mysql:import"
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

