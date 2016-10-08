
module PixelValidation

  def pixels_valid?(pixels)
    return false unless pixels.length < 500
    return false unless pixels[0].length < 500

    pixels.each_with_index do |line, x|
      line.each do |y|
        return false unless rgba_valid? pixels[x][y]
      end
    end
    return true
  end

  def rgba_valid?(rgba)
    return false unless rgba.is_a? Hash
    return false unless (%w(r g b a) - rgba.keys).empty?
    return false unless rgba.values.all? { |val| val.to_s =~ /[0-9]/ }
    return false unless rgba.values.all? { |val| val.to_i.between? 0, 255 }
    return true
  end

end
