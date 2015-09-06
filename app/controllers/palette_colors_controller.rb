class PaletteColorsController < ApplicationController
  respond_to :html

  def create
  end

  def destroy
    palette_owner = pc.palette.user
    if palette_owner == current_user
      pc = PaletteColor.find(params[:id])
      p_id = pc.palette_id
      pc.destroy
      redirect_to Palette.find(p_id)
    else
      head :unauthorized
    end
  end

end
