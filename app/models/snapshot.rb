class Snapshot < ActiveRecord::Base
  include SnapshotsHelper

  belongs_to :picture, inverse_of: :snapshots

  validates :picture, presence: true
  validates :cell_size, numericality: { less_than_or_equal_to: 50 }

  def original_png
    get_file('original')
  end

  def thumbnail_png
    get_file('thumbnail')
  end

  def display_png
    get_file('display')
  end

  def file_name(size_tag)
    return "#{created_at.to_i}_#{id}_#{size_tag}.png"
  end

  def get_file(size_tag)
    return File.open("#{ENV['PNG_STORE_DIR']}/#{file_name(size_tag)}") { |io| image = ChunkyPNG::Image.from_io(io) }
  end

  def save_pngs!(pixels)
    FileUtils.mkdir_p(ENV['PNG_STORE_DIR']) unless File.directory?(ENV['PNG_STORE_DIR'])

    original_png = build_png(pixels)
    thumbnail_png = get_resized_png(original_png, 128)
    display_png = get_resized_png(original_png, 512)
    original_file_name = file_name('original')
    thumbnail_file_name = file_name('thumbnail')
    display_file_name = file_name('display')

    original_png.save("#{ENV['PNG_STORE_DIR']}/#{original_file_name}")
    thumbnail_png.save("#{ENV['PNG_STORE_DIR']}/#{thumbnail_file_name}")
    display_png.save("#{ENV['PNG_STORE_DIR']}/#{display_file_name}")
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
    ['original', 'thumbnail', 'display'].each do |tag|
      src_name = "#{ENV['PNG_STORE_DIR']}/#{file_name(tag)}"
      dest_name = "#{ENV['PNG_STORE_DIR']}/#{new_ss.file_name(size_tag)}"
      File.copy(src_name, dest_name)
    end
    new_ss.save!
    return new_ss
  end

end
