
{
  name: @palette.name,
  id: @palette.id,
  colors: @palette.colors.map do |color|
    {
      r: color.r,
      g: color.g,
      b: color.b,
      a: color.a
    }
  end

}.to_json
