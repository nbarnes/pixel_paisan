class PalettesController < ApplicationController
  before_action :set_palette, only: [:show, :edit, :update, :destroy]

  def index
    @palettes = Palette.all
  end

  def show
  end

  def new
  end

  def new_color
    @palette = Palette.find(params[:id])
    @color = Color.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_palette
      @palette = Palette.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def palette_params
      params.require(:palette).permit(:name)
    end

end