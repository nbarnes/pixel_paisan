class ColorsController < ApplicationController
  respond_to :html, :js

  # GET /colors
  # GET /colors.json
  def index
    @colors = Color.all
  end

  def create
    respond_to do |format|
      format.html {
        @palette = Palette.find(params[:color][:palette][:id])
        @color = Color.create!(color_params)
        @palette_color = @palette.palette_colors.build
        @palette_color.color_id = @color.id
        @palette_color.save
        render 'palettes/add_new_palette_color', color: @color
      }
      format.json {
        puts 'got a json request in ColorsController.create'
      }
    end
  end

  def destroy
    Color.find(params[:id]).destroy
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
