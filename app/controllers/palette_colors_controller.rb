class PaletteColorsController < ApplicationController
  respond_to :html

  def create
  end

  def destroy
    pc = PaletteColor.find(params[:id])
    p_id = pc.palette_id
    pc.destroy
    redirect_to Palette.find(p_id)
  end

end