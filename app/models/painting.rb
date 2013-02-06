class Painting < ActiveRecord::Base
  attr_accessible :description, :name, :pub_year, :image, :tag_list
  mount_uploader :image, ImageUploader
  acts_as_taggable
end
