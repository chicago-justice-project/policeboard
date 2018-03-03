
CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

  config.fog_provider = 'fog/aws'

  config.fog_credentials = {
    provider:              'AWS',
    region:                ENV["AWS_REGION"],               # optional, defaults to 'us-east-1'
    aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"] || 'awskey',
    aws_secret_access_key: ENV["AWS_SECRET_KEY"] || 'awssecret'
  }

  config.fog_directory = 'policeboard-production'

  config.fog_public     = true    # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}

  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
end

