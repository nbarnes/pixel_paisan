class CreatePngsJob < ActiveJob::Base
  include PngHelper

  queue_as :default

  def perform(file_prefix)

    return unless File.exist?("tmp/pixel_files/#{file_prefix}pixel_file.json")

    pixels = JSON.parse(File.read("tmp/pixel_files/#{file_prefix}pixel_file.json"))

    original_png = build_png(pixels)
    thumbnail_png = get_resized_png(original_png, 128)
    display_png = get_resized_png(original_png, 512)

    original_file_name = "#{file_prefix}original.png"
    thumbnail_file_name = "#{file_prefix}thumbnail.png"
    display_file_name = "#{file_prefix}display.png"

    original_png.save("#{ENV['PNG_STORE_DIR']}/#{original_file_name}")
    thumbnail_png.save("#{ENV['PNG_STORE_DIR']}/#{thumbnail_file_name}")
    display_png.save("#{ENV['PNG_STORE_DIR']}/#{display_file_name}")

    StorePngToS3Job.perform_later file_prefix

    File.delete("tmp/pixel_files/#{file_prefix}pixel_file.json")

  end

end
