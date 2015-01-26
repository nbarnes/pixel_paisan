class PngToS3StoreWorker
  include Sidekiq::Worker
  def perform(file_path)

    connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY'],
      :region                   => ENV['AWS_REGION']
    })

    directory = connection.directories.get(ENV['S3_BUCKET_NAME'])

    ['original', 'thumbnail', 'display'].each do |tag|
      puts "file name = #{ENV['PNG_STORE_DIR']}/#{file_path}#{tag}.png"
      file = File.open("#{ENV['PNG_STORE_DIR']}/#{file_path}#{tag}.png") { |io| image = ChunkyPNG::Image.from_io(io) }
      remote_file = directory.files.create(
        :key    => "#{file_path}#{tag}.png",
        :body   => file.to_blob,
        :public => false
      )
    end

  end
end