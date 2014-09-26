class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  # GET /colors
  # GET /colors.json
  def index
    @colors = Color.all
  end

  def edit
  end

  def new
    @color = Color.new
  end

  def create
    @palette = Palette.find(params[:color][:palette][:id])
    @color = Color.create!(color_params)
    palette_color = @palette.palette_colors.build
    palette_color.color_id = @color.id
    palette_color.save
  end

  def update
    @color.update_attributes(color_params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_params
      params.require(:color).permit(:r, :g, :b, :a)
    end
end
