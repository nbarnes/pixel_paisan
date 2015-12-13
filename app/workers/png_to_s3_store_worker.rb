
# rubocop:disable Lint/UselessAssignment
class PngToS3StoreWorker
  include CloudHelper
  include Sidekiq::Worker

  def perform(file_path)
    directory = fog_connection.directories.get(ENV['S3_BUCKET_NAME'])
    %w('original', 'thumbnail', 'display').each do |tag|
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
# rubocop:enable Lint/UselessAssignment
