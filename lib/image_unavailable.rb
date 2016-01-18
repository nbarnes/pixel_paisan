
  module ImageUnavailable
  def image_unavailable_png
    return File.open("app/assets/images/image_unavailable.png") { |io| image = ChunkyPNG::Image.from_io(io) }
  end
end

