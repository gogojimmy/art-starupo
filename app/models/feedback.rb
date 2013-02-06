class Feedback < ActiveRecord::Base
  attr_accessible :email, :message, :name, :phone
  validates_presence_of :email, :name, :message
end
