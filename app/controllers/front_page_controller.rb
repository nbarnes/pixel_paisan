class FrontPageController < ApplicationController

  def welcome
    @palettes = Palette.where(is_default: true)
    if user_signed_in?
      @palettes.concat Palette.where(user_id: current_user.id)
    end
  end

end
