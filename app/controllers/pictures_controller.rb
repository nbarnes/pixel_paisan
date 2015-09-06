class PicturesController < ApplicationController

  before_action :set_picture, only: [:show, :edit, :destroy]

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: @picture.as_json
      end
    end
  end

  def destroy
    if @picture.user == current_user
      picture_gallery = @picture.gallery
      @picture.destroy
      redirect_to gallery_path(picture_gallery)
    else
      head :unauthorized
    end
  end

  def edit
    unless @picture.user == current_user
      @picture = @picture.copy_for_branch(current_user)
      redirect_to edit_picture_path(@picture)
    end
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
