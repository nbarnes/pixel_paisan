class PalettesController < ApplicationController
  include PalettesHelper
  include PixelValidation
  before_action :set_palette, except: [:index, :user_index, :new, :create]
  respond_to :html

  def index
    @palettes = Palette.all
  end

  def user_index
    @palettes = Palette.where(user_id: params[:user_id])
  end

  def show
    respond_to do |format|
      format.html do
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
      palette_name = @palette.name
      @palette.destroy
      redirect_to user_palettes_path(current_user), notice: "Palette '#{palette_name}' was deleted."
    else
      head :unauthorized
    end
  end

  def new_color
  end

  def create_color
    head :unauthorized && return unless current_palette_owner
    @new_color = { 'r' => params[:r], 'g' => params[:g], 'b' => params[:b], 'a' => params[:a] }
    head :bad_request && return unless rgba_valid? @new_color
    @palette.colors << @new_color
    @palette.save!

    respond_to do |format|
      format.html do
        redirect_to @palette
      end
      format.json do
        render :create_color
      end
    end
  end

  def delete_color
    head :unauthorized && return unless current_palette_owner
    removed_color = { 'r' => params[:r], 'g' => params[:g], 'b' => params[:b], 'a' => '1' }
    head :bad_request && return unless rgba_valid? removed_color
    @palette.colors.reject! do |color|
      color == removed_color
    end
    @palette.save!
    redirect_to @palette
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
