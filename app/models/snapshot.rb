class Snapshot < ActiveRecord::Base
  include SnapshotsHelper

  belongs_to :picture, inverse_of: :snapshots

  validates :picture, presence: true

  def original_png
    return File.open(storage_dir + '/original.png', 'rb') { |io| image = ChunkyPNG::Image.from_io(io) }
  end

  def thumbnail_png
    return File.open(storage_dir + '/thumbnail.png', 'rb') { |io| image = ChunkyPNG::Image.from_io(io) }
  end

  def display_png
    return File.open(storage_dir + '/display.png', 'rb') { |io| image = ChunkyPNG::Image.from_io(io) }
  end

  def storage_dir
    dir = "#{Rails.root}/user_images/user_#{picture.user.id}/snapshot_#{id}"
  end

  def save_pngs!(pixels)
    FileUtils.mkdir_p(storage_dir) unless File.directory?(storage_dir)

    original_png = build_png(pixels)
    thumbnail_png = get_resized_png(original_png, 128)
    display_png = get_resized_png(original_png, 512)

    original_png.save(storage_dir + "/original.png")
    thumbnail_png.save(storage_dir + "/thumbnail.png")
    display_png.save(storage_dir + "/display.png")
  end

end
