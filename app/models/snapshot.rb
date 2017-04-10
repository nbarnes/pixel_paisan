class Snapshot < ActiveRecord::Base
  include PngHandler
  include ImageUnavailable

  belongs_to :picture, inverse_of: :snapshots, counter_cache: true

  validates :picture, presence: true
  validates :cell_size, numericality: { less_than_or_equal_to: 50 }

  after_create :update_picture

  scope :created_between, ->(start_date, end_date) { where(created_at: start_date..end_date) }

  def original_png
    get_file('original')
  end

  def thumbnail_png
    get_file('thumbnail')
  end

  def display_png
    get_file('display')
  end

  def get_file(size_tag)
    file_path = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{size_tag}.png"
    make_png(size_tag) unless File.exist? file_path
    return File.open(file_path) { |io| image = ChunkyPNG::Image.from_io(io) }
  end

  def make_png(size_tag)
    original_png = build_png(pixels)
    if size_tag == ENV['THUMBNAIL_SIZE_TAG']
      png = get_resized_png(original_png, ENV['THUMBNAIL_SIZE'].to_i)
      file_name = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{ENV['THUMBNAIL_SIZE_TAG']}.png"
    elsif size_tag == ENV['DISPLAY_SIZE_TAG']
      png = get_resized_png(original_png, ENV['DISPLAY_SIZE'].to_i)
      file_name = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{ENV['DISPLAY_SIZE_TAG']}.png"
    else
      png = original_png
      file_name = "#{ENV['PNG_STORE_DIR']}/#{file_prefix}#{ENV['ORIGINAL_SIZE_TAG']}.png"
    end

    png.save(file_name)
  end

  def file_prefix
    return "#{created_at.to_i}_#{id}_"
  end

  def branch(new_pic)
    new_ss = Snapshot.new(
      cell_size: cell_size,
      picture: new_pic,
      pixels: pixels
    )
    new_ss.save!
    return new_ss
  end

  def update_picture
    picture.snapshot_updated_at = created_at
    picture.save!
  end

end
