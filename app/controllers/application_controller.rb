class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def palettes
    palettes = Palette.where(is_default: true)
    if user_signed_in?
      palettes.concat Palette.where(user_id: current_user.id)
    end
    return palettes
  end

end
