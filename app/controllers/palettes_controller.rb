class PalettesController < ApplicationController
  before_action :set_palette, only: [:show, :edit, :update, :destroy, :return_json]
  respond_to :html

  def index
    @palettes = Palette.all
  end

  def show
    respond_to do |format|
      format.html
        @palette_colors = PaletteColor.where(palette_id: @palette.id)
      format.json
    end
  end

  def new
    @palette = Palette.new
  end

  def create
    @palette = Palette.new(palette_params)
    if @palette.save
      redirect_to @palette
    else
      redirect_to palettes_path, notice: 'Palette save failed.'
    end
  end

  def destroy
    @palette.destroy
    redirect_to palettes_url, notice: "Pallete '#{@palette.name} was deleted."
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