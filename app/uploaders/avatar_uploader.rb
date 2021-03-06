# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    asset_path([version_name, 'default-avatar.jpg'].compact.join('-'))
  end

  version :normal do
    process :fix_exif_rotation
    process :strip
    process :resize_to_limit => [300, 0]
    process :quality => 100
  end

  version :small do
    process :fix_exif_rotation
    process :strip
    process :resize_to_limit => [100, 0]
    process :quality => 100
  end

  version :thumb do
    process :fix_exif_rotation
    process :strip
    process :resize_to_limit => [50, 0]
    process :quality => 100
  end

  version :for_index do
    process :fix_exif_rotation
    process :strip
    process :resize_to_limit => [0, 350]
    process :quality => 100
  end

end
