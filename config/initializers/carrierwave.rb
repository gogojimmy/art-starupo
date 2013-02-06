module CarrierWave
  module RMagick

    def fix_exif_rotation
      manipulate! do |img|
        img.auto_orient!
        img = yield(img) if block_given?
        img
      end
    end

    # Strips out all embedded information from the image
    def strip
      manipulate! do |img|
        img.strip!
        img = yield(img) if block_given?
        img
      end
    end

    # Reduces the quality of the image to the percentage given
    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage }
        img = yield(img) if block_given?
        img
      end
    end

  end
end

