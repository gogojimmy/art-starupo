#encoding: utf-8
class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.create(params[:feedback])
    if @feedback.save
      respond_to do |format|
        format.js
      end
    else
      render :new
    end
  end
end
