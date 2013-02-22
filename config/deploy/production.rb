set :rails_env, "production"
set :user, "deployer"
set :domain, "art.startupo.cc"
set :branch, "master"

server "#{domain}", :web, :app, :db, :primary => true
set :deploy_to, "/home/#{user}/#{application}"
