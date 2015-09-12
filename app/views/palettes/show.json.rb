
{
  name: @palette.name,
  id: @palette.id,
  current_user_is_owner: current_user == @palette.user,
  colors: @palette.colors.map do |color|
    {
      r: color.r,
      g: color.g,
      b: color.b,
      a: color.a
    }
  end

}.to_json
