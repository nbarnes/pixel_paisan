
{
  name: @palette.name,
  id: @palette.id,
  current_user_is_owner: current_user == @palette.user,
  colors: @palette.colors

}.to_json
