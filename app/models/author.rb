class Author < ActiveRecord::Base
  attr_accessible :description, :name, :avatar
  has_many :paintings

  mount_uploader :avatar, AvatarUploader
end
