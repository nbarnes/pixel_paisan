
module CloudHelper
  def fog_connection
    # rubocop:disable Style/BracesAroundHashParameters
    connection = Fog::Storage.new({
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION']
    })
    # rubocop:enable Style/BracesAroundHashParameters
  end
end
