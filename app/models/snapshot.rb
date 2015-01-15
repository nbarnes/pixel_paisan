class Snapshot < ActiveRecord::Base
  include SnapshotsHelper

  belongs_to :picture, inverse_of: :snapshots

  validates :picture, presence: true
  validates :cell_size, numericality: { less_than_or_equal_to: 50 }

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

  def image_data_json
    image_data = Array.new
    png = original_png

    dimension = png.height

    dimension.times do |x|
      image_data.push Array.new
      dimension.times do |y|
        image_data[x][y] = extract_ChunkyPNG_color(png.pixels[(dimension*y + x)])
      end
    end

    return image_data
  end

  def copy_for_branch(new_pic)
    new_ss = Snapshot.new
    new_ss.cell_size = cell_size
    new_ss.picture = new_pic
    new_ss.save!
    new_dir = new_ss.storage_dir
    FileUtils.mkdir_p(new_dir) unless File.directory?(new_dir)
    FileUtils.cp_r("#{storage_dir}/.", new_dir)
  end

end
