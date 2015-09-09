
module PalettesHelper

  def current_palette_owner
    return user_signed_in? && (current_user.id == @palette.user_id)
  end

  def string_to_css_id(name)
    return name.gsub(/( )/, '_').gsub(/(['"`])/, '')
  end

end
