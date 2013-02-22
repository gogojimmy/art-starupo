class Painting < ActiveRecord::Base
  attr_accessible :description, :name, :pub_year, :image, :tag_list, :author_id
  mount_uploader :image, ImageUploader
  acts_as_taggable
  validates_presence_of :name, :image, :description, :author_id
  belongs_to :author

  delegate :name, to: :author, prefix: true, allow_nil: true

  def related_paintings(count=5)
    Painting.where(:author_id => self.author_id).sample(count)
  end

end
