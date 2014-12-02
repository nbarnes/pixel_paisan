module SnapshotsHelper

  require 'chunky_png'
  require 'rmagick'
  require 'chunky_png/rmagick'


  def build_png(rgba)
    png_dimension = rgba.size
    png = ChunkyPNG::Image.new(png_dimension, png_dimension, ChunkyPNG::Color::TRANSPARENT)

    rgba.each_with_index do |line, x|
      line.each_with_index do |column, y|
        png[x,y] = build_ChunkyPNG_color(rgba[x][y])
      end
    end
    return png
  end

  def build_ChunkyPNG_color(rgba_obj)
    alpha = alpha_as_255(rgba_obj["a"])
    ChunkyPNG::Color.rgba(rgba_obj["r"], rgba_obj["g"], rgba_obj["b"], alpha)
  end

  def alpha_as_255(a)
    return a*255
  end

  def get_resized_png(canvas, dimension)
    resized_image = ChunkyPNG::RMagick.export(canvas).scale(dimension, dimension)
    return ChunkyPNG::RMagick.import(resized_image)
  end

  def save_png_file(png, user_id, snapshot_id)
    dir = "user_images/user_#{user_id}/#{snapshot_id}"
    thumbnail = get_resized_png(png, 200)
    display = get_resized_png(png, 600)
    png.save(dir)
    thumnail.save(dir)
    display.save(dir)
  end

end
