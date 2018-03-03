
CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    # config.fog_directory  = 'policeboard-staging'
    config.storage = :file
  end

  if Rails.env.production?
    config.storage = :fog

    config.fog_provider = 'fog/aws'

    config.fog_credentials = {
      provider:              'AWS',
      region:                ENV["AWS_REGION"],               # optional, defaults to 'us-east-1'
      aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_KEY"]
    }

    config.fog_directory = 'policeboard-production'

    config.fog_public     = true    # optional, defaults to true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
  end
end

