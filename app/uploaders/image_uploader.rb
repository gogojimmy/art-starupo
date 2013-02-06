# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

 include CarrierWave::RMagick
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :usual do
    process :resize_to_limit => [300, 300]
  end

  version :thumb do
    process :resize_to_limit => [100, 100]
  end

end
