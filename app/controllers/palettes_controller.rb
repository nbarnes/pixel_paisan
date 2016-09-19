class PalettesController < ApplicationController
  include PalettesHelper
  before_action :set_palette, except: [:index, :user_index, :new]
  respond_to :html

  def index
    @palettes = Palette.all.eager_load(:colors)
  end

  def user_index
    @palettes = Palette.where(user_id: params[:user_id]).eager_load(:colors)
  end

  def show
    respond_to do |format|
      format.html do
        @palette_colors = PaletteColor.where(palette_id: @palette.id)
      end
      format.json do
      end
    end
  end

  def new
    @palette = Palette.new
  end

  def create
    @palette = Palette.new(palette_params)
    @palette.user_id = current_user.id
    if @palette.save
      redirect_to @palette
    else
      redirect_to palettes_path, notice: 'Palette save failed.'
    end
  end

  def destroy
    if @palette.user == current_user
      @palette.destroy
      redirect_to palettes_path, notice: "Pallete '#{@palette.name}' was deleted."
    else
      head :unauthorized
    end
  end

  def create_color
    @new_color = {r: params[:r], g: params[:g], b: params[:b]}
    @palette.colors.push(@new_color) unless @palette.colors.include? @new_color
  end

  def delete_color
    @color = Color.find(params[:id])
    if @color.palette.user == current_user
      @color.destroy
      redirect_to palette_path
    else
      head :unauthorized
    end
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
