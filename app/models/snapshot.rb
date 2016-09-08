class Snapshot < ActiveRecord::Base
  include PngHelper
  include ImageUnavailable

  belongs_to :picture, inverse_of: :snapshots, counter_cache: true

  validates :picture, presence: true
  validates :cell_size, numericality: { less_than_or_equal_to: 50 }

  scope :created_between, lambda {|start_date, end_date| where(created_at: start_date..end_date)}

  def initialize(opts = {})

    pixels = opts[:pixels]

    super opts.except! :pixels

    if pixels
      original_png = build_png(pixels)
      thumbnail_png = get_resized_png(original_png, THUMBNAIL_SIZE)
      display_png = get_resized_png(original_png, DISPLAY_SIZE)

      self.original_png_width = pixels.size
      self.original_png_height = pixels[0].size

      self.original_png_blob = original_png.to_abgr_stream
      self.thumbnail_png_blob = thumbnail_png.to_abgr_stream
      self.display_png_blob = display_png.to_abgr_stream
    end

  end

  def original_png
    get_file(ENV['ORIGINAL_SIZE_TAG'])
  end

  def thumbnail_png
    get_file(ENV['THUMBNAIL_SIZE_TAG'])
  end

  def display_png
    get_file(ENV['DISPLAY_SIZE_TAG'])
  end

  def file_prefix
    return "#{created_at.to_i}_#{id}_"
  end

  def get_file(size_tag)
    file_path = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{size_tag}.png"
    make_pngs unless File.exist? file_path
    return File.open( file_path ) { |io| image = ChunkyPNG::Image.from_io(io) }
  end

  def make_pngs
    original_png = ChunkyPNG::Image.from_abgr_stream(original_png_width, original_png_height, original_png_blob)
    thumbnail_png = ChunkyPNG::Image.from_abgr_stream(THUMBNAIL_SIZE, THUMBNAIL_SIZE, thumbnail_png_blob)
    display_png = ChunkyPNG::Image.from_abgr_stream(DISPLAY_SIZE, DISPLAY_SIZE, display_png_blob)

    original_file_name = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{ENV['ORIGINAL_SIZE_TAG']}.png"
    thumbnail_file_name = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{ENV['THUMBNAIL_SIZE_TAG']}.png"
    display_file_name = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{ENV['DISPLAY_SIZE_TAG']}.png"

    original_png.save(original_file_name)
    thumbnail_png.save(thumbnail_file_name)
    display_png.save(display_file_name)
  end

  def image_json
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
    new_ss = Snapshot.new({

      riginal_png_width: self.original_png_width,
      original_png_height: self.original_png_height,

      original_png_blob: self.original_png_blob,
      thumbnail_png_blob: self.thumbnail_png_blob,
      display_png_blob: self.display_png_blob,

      cell_size: self.cell_size,
      picture: new_pic
    })
    new_ss.save!
    return new_ss
  end

end
