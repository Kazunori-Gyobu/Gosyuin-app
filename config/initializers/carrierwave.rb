module CarrierWave
  module MiniMagick
    def fix_exif_rotation
      manipulate! do |image|
        image.auto_orient
        image = yield(image) if block_given?
        image
      end
    end
  end
end