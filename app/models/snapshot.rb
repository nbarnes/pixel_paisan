class Snapshot < ActiveRecord::Base
  include PngHelper
  include ImageUnavailable

  belongs_to :picture, inverse_of: :snapshots

  validates :picture, presence: true
  validates :cell_size, numericality: { less_than_or_equal_to: 50 }

  def test_after_create
    puts 'this fired during the after_create hook'
  end

  def populate(pixel_data, cell_size)
    self.cell_size = cell_size

    original_png = build_png(pixel_data)
    thumbnail_png = get_resized_png(original_png, 128)
    display_png = get_resized_png(original_png, 512)

    original_file_name = "#{file_prefix}original.png"
    thumbnail_file_name = "#{file_prefix}thumbnail.png"
    display_file_name = "#{file_prefix}display.png"

    original_png.save("#{ENV['PNG_STORE_DIR']}/#{original_file_name}")
    thumbnail_png.save("#{ENV['PNG_STORE_DIR']}/#{thumbnail_file_name}")
    display_png.save("#{ENV['PNG_STORE_DIR']}/#{display_file_name}")

    encoded_original_png = original_png.to_blob
    encoded_thumbnail_png = thumbnail_png.to_blob
    encoded_display_png = display_png.to_blob
  end

  def original_png
    get_file('original')
  end

  def thumbnail_png
    get_file('thumbnail')
  end

  def display_png
    get_file('display')
  end

  def file_prefix
    return "#{created_at.to_i}_#{id}_"
  end

  def get_file(size_tag)
    file_name = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{size_tag}.png"
    if File.exist? file_name
      file = File.open( file_name ) { |io| image = ChunkyPNG::Image.from_io(io) }
    else
      file = image_unavailable(size_tag)
    end
    return file
  end

  # def save_pngs!(pixels)
  #   File.open("tmp/pixel_files/#{file_prefix}pixel_file.json", 'w+') { |file| file.write(pixels.to_json) }

  #   CreatePngsJob.perform_later file_prefix
  # end

  def image_data_json
    image_data = []
    png = original_png

    dimension = png.height

    dimension.times do |x|
      image_data.push []
      dimension.times do |y|
        image_data[x][y] = extract_ChunkyPNG_color(png.pixels[(dimension * y + x)])
      end
    end

    return image_data
  end

  def branch(new_pic)
    new_ss = Snapshot.new
    new_ss.cell_size = cell_size
    %w('original', 'thumbnail', 'display').each do |tag|
      src_name = "#{ENV['PNG_STORE_DIR']}/#{file_name(tag)}"
      dest_name = "#{ENV['PNG_STORE_DIR']}/#{new_ss.file_name(size_tag)}"
      File.copy(src_name, dest_name)
    end
    new_ss.save!
    return new_ss
  end

end
