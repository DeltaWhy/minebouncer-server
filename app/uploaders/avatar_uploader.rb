class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  process :decapitate
  def decapitate
    manipulate! do |img|
      img.crop "8x8+8+8"
      img = yield(img) if block_given?
      img
    end
  end
  def scale(w,h)
    manipulate! do |img|
      img.scale "#{w}x#{h}"
      img = yield(img) if block_given?
      img
    end
  end

  version :sm do
    process :scale => [16,16]
  end
  version :med do
    process :scale => [32,32]
  end
  version :lg do
    process :scale => [48,48]
  end
  version :xl do
    process :scale => [64,64]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
     "images/fallback/" + [version_name, "avatar.png"].compact.join('_')
  end
end
