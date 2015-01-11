class PicturesController < ApplicationController

  before_action :set_picture, only: [:show, :edit, :destroy]

  def show
    respond_to do |format|
      format.html
      format.json do
        render :json => @picture.as_json
      end
    end
  end

  def destroy
    @picture.destroy
  end

  def edit
    @palettes = Palette.where(is_default: true)
    if user_signed_in?
      @palettes.concat Palette.where(user_id: current_user.id)
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

end
