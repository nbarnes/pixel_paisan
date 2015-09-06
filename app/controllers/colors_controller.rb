class ColorsController < ApplicationController
  before_action :set_gallery, only: [:destroy]
  respond_to :html, :js

  def index
    @colors = Color.all
  end

  def create
    respond_to do |format|
      format.js do
        @palette = Palette.find(params[:color][:palette][:id])
        head :unauthorized unless user_signed_in? && @palette.user_id == current_user.id

        @color = Color.create!(color_params)
        @palette_color = @palette.palette_colors.build
        @palette_color.color_id = @color.id
        @palette_color.save
        render 'palettes/add_new_palette_color', color: @color, palette: @palette

      end
      format.json do
        @palette = Palette.find(params[:palette_id])
        head :unauthorized unless user_signed_in? && @palette.user_id == current_user.id

        @color = Color.create!(r: params[:r], g: params[:g], b: params[:b], a: params[:a])
        @palette_color = @palette.palette_colors.build
        @palette_color.color_id = @color.id
        @palette_color.save
        render :create

      end
    end
  end

  def destroy
    throw Exception('Exception in ColorsController#destroy')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_params
      params.require(:color).permit(:r, :g, :b, :a, :palette)
    end
end
