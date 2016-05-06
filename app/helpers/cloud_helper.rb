
module CloudHelper

  def local_fog_connection
    Fog::Storage.new({
      :local_root => "#{Rails.root}/test/fog",
      :provider   => 'Local'
    })
  end

  def s3_fog_connection
    Fog::Storage.new({
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION']
    })
  end

end
