
module ImageUnavailable

  def image_unavailable(size_tag)
    return File.open("app/assets/images/image_unavailable_#{size_tag}.png") { |io| image = ChunkyPNG::Image.from_io(io) }
  end

end

