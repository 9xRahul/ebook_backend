Cloudinary.config do |config|
  config.cloud_name = ENV.fetch('CLOUDINARY_CLOUD_NAME', 'sample')
  config.api_key = ENV.fetch('CLOUDINARY_API_KEY', '874837483274837')
  config.api_secret = ENV.fetch('CLOUDINARY_API_SECRET', 'a676b67565c6767a6767d6767f676fe1')
  config.secure = true
end
