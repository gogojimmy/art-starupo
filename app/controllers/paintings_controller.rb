class PaintingsController < ApplicationController

  def index
    if params[:tag]
      @paintings = Painting.tagged_with(params[:tag]).paginate(page: params[:page])
    else
      @paintings = Painting.paginate(page: params[:page])
    end
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @painting = Painting.find(params[:id])
  end

end
