#encoding: utf-8
class Admin::PostsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to admin_posts_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to admin_posts_path, notcie: '新增成功'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: '刪除成功'
  end

end
