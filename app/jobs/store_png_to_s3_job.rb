class StorePngToS3Job < ActiveJob::Base
  include CloudHelper

  queue_as :default

  def perform(file_path)

    if Rails.env.development? || Rails.env.test?
      directory = local_fog_connection.directories.get(ENV['S3_BUCKET_NAME'])
    else
      directory = s3_fog_connection.directories.get(ENV['S3_BUCKET_NAME'])
    end

    %w(original thumbnail display).each do |tag|
      puts "file name = #{ENV['PNG_STORE_DIR']}/#{file_path}#{tag}.png"
      file = File.open("#{ENV['PNG_STORE_DIR']}/#{file_path}#{tag}.png") do |io|
        image = ChunkyPNG::Image.from_io(io)
      end
      remote_file = directory.files.create(
        key:    "#{file_path}#{tag}.png",
        body:   file.to_blob,
        public: false
      )
    end

  end

end
