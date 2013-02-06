class Painting < ActiveRecord::Base
  attr_accessible :description, :name, :pub_year, :image
  mount_uploader :image, ImageUploader
end
