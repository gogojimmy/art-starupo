#encoding: utf-8
class Admin::AuthorsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def index
    @authors = Author.paginate(page: params[:page])
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(params[:author])
    if @author.save
      redirect_to admin_author_path(@author), notice: '作家新增成功'
    else
      render :new
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      redirect_to admin_author_path(@author), notice: '作者更新成功'
    else
      render :edit
    end
  end

  def destory
    @author = Author.find(params[:id])
    @author.destroy
    redirect_to admin_authors_path, notice: '作者刪除成功'
  end

end

