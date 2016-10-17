class StaticPagesController < ApplicationController

  def editor
    @user_id = current_user.try(:id)
    default_palettes = Palette.where(is_default: true)
    user_palettes = Palette.where(user_id: @user_id)
    @palettes = (default_palettes + user_palettes).uniq
    @picture_id = params[:picture_id]
  end

  def faq
  end

end
