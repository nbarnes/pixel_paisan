class PngToS3StoreWorker
  include Sidekiq::Worker

  def perform(file_path)

    puts 'png_to_s3_store_worker triggered'

  end

end