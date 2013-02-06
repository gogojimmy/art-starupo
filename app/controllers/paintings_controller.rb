class PaintingsController < ApplicationController

  def index
    @paintings = Painting.paginate(page: params[:page])
  end

  def show
    @painting = Painting.find(params[:id])
  end

end
