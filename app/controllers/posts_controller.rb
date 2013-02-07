class PostsController < ApplicationController

  before_filter :load_sidebar

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  protected

  def load_sidebar
    @latest = Post.last(5)
  end

end
