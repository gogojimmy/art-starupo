class Admin::FeedbacksController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def index
    @feedbacks = Feedback.paginate(page: params[:page])
  end

  def show
    @feedback = Feedback.find(params[:id])
  end

end
