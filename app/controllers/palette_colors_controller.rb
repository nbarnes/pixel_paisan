class PaletteColorsController < ApplicationController
  respond_to :html

  def new
    @palette = nil
    @color = Color.new
  end

  def create
  end

  def destroy
    palette_color = PaletteColor.find(params[:id])
    palette_owner = palette_color.palette.user
    head :unauthorized unless palette_owner == current_user
    palette = Palette.find(palette_color.palette_id)
    palette_color.destroy
    redirect_to palette
  end

end
