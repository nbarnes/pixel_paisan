
{
  name: @palette.name,
  id: @palette.id,
  is_default_palette: (@palette.is_default ? 1 : 0),
  colors: @palette.colors

}.to_json
