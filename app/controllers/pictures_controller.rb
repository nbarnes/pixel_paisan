class PicturesController < ApplicationController
  include PixelValidation

  before_action :set_picture, only: [:show, :update, :destroy, :edit]

  def show
  end

  def destroy
    head :unauthorized && return unless @picture.user == current_user
    picture_gallery = @picture.gallery
    @picture.destroy
    redirect_to gallery_path(picture_gallery)
  end

  def create
    head :bad_request && return unless pixels_valid? params[:pixels]
    head :unauthorized && return unless current_user
    picture = Picture.new
    picture.name = params[:name]
    picture.user_id = current_user.id
    picture.gallery = current_user.galleries[0]
    picture.add_snapshot(params) if params[:pixels]
    picture.save!

    render json: {
      message: 'Picture creation success',
      status: 200,
      picture_id: picture.id,
      picture_name: picture.name
    }, status: 200
  end

  def edit
    respond_to do |format|
      format.html do
        unless @picture.user == current_user
          @picture = @picture.branch(current_user)
          redirect_to edit_picture_path(@picture)
        end
        @palettes = user_palettes
        @picture_id = @picture.id
      end
      format.json do
        render json: @picture.editor_json
      end
    end
  end

  def update
    head :bad_request && return unless pixels_valid? params[:pixels]
    head :unauthorized && return unless @picture.user == current_user
    @picture.name = params[:picture_name] if params[:picture_name]
    @picture.add_snapshot(params) if params[:pixels]
    @picture.save!
    render json: {
      message: 'Picture update success',
      picture_name: @picture.name,
      status: 200
    }, status: 200
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params[:picture].permit(:name)
    end

end
