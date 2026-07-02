class EbookUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def extension_allowlist
    %w(pdf epub)
  end

  # Tells Cloudinary to upload the actual file type,never attempting to convert it to an image
  process :resource_type => :raw

  def size_range
    1.byte..100.megabytes
  end
end
