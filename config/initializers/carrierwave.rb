require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Settings.ACCESS_KEY_ID,
    aws_secret_access_key: Settings.SECRET_ACCESS_KEY,
    region: 'us-east-1'
  }

    case Rails.env
    when 'development'
        config.fog_directory  = 'chat-space-uploading-testing'
        config.asset_host = 'https://s3.amazonaws.com/chat-space-uploading-testing'
    when 'production'
        config.fog_directory  = 'chat-space-uploading-testing'
        config.asset_host = 'https://s3.amazonaws.com/chat-space-uploading-testing'
    end
end
