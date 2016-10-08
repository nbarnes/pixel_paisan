module PngHandler

  require 'chunky_png'
  require 'rmagick'
  require 'chunky_png/rmagick'

  def build_png(pixels)
    png_dimension = pixels.size
    png = ChunkyPNG::Image.new(png_dimension, png_dimension, ChunkyPNG::Color::TRANSPARENT)

    pixels.each_with_index do |line, x|
      line.each do |y|
        png[x, y] = build_ChunkyPNG_color(pixels[x][y])
      end
    end

    return png
  end

  def build_ChunkyPNG_color(rgba_obj)
    alpha = alpha_as_255(rgba_obj['a'])
    ChunkyPNG::Color.rgba(rgba_obj['r'], rgba_obj['g'], rgba_obj['b'], alpha)
  end

  def alpha_as_255(a)
    return a * 255
  end

  def alpha_as_0_1(a255)
    return a255 / 255.0
  end

  def extract_ChunkyPNG_color(color)
    alpha = alpha_as_0_1(ChunkyPNG::Color.a(color))
    return { r: ChunkyPNG::Color.r(color), g: ChunkyPNG::Color.g(color), b: ChunkyPNG::Color.b(color), a: alpha }
  end

  def get_resized_png(canvas, dimension)
    resized_image = ChunkyPNG::RMagick.export(canvas).scale(dimension, dimension)
    return ChunkyPNG::RMagick.import(resized_image)
  end

end
