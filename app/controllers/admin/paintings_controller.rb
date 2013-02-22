#encoding: utf-8
class Admin::PaintingsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def index
    @paintings = Painting.paginate(page: params[:page])
  end

  def show
    @painting = Painting.find(params[:id])
  end

  def new
    @painting = Painting.new
  end

  def create
    @painting = Painting.new(params[:painting])
    if @painting.save
      redirect_to admin_painting_path(@painting), notice: '作品新增成功'
    else
      render :new
    end
  end

  def edit
    @painting = Painting.find(params[:id])
  end

  def update
    @painting = Painting.find(params[:id])
    if @painting.update_attributes(params[:painting])
      redirect_to admin_painting_path(@painting), notice: '作品更新成功'
    else
      render :edit
    end
  end

  def destory
    @painting = Painting.find(params[:id])
    @painting.destroy
    redirect_to admin_paintings_path, notice: '作品刪除成功'
  end

end

