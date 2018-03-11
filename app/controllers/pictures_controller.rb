class PicturesController < ApplicationController
  include PixelValidation
  include StringValidation

  before_action :set_picture, only: %i[show update destroy edit]

  def show
    respond_to do |format|
      format.html do
        @picture_id = @picture.id
        @current_user_id = current_user.try(:id)
      end
      format.json { render json: @picture.editor_json }
      format.png do
        (head :bad_request) && return unless @picture
        send_data @picture.current_version.get_png(params[:size]), type: 'image/png', disposition: 'inline'
      end
    end
  end

  def destroy
    (head :unauthorized) && return unless @picture.user == current_user
    picture_gallery = @picture.gallery
    @picture.destroy
    redirect_to gallery_path(picture_gallery)
  end

  def create
    (head :bad_request) && return unless pixels_valid? params[:pixels]
    (head :unauthorized) && return unless current_user

    picture = Picture.new
    picture.name = massage_name params[:name]
    picture.palette_id = params[:palette_id]
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
    @user_id = current_user.try(:id)
    @picture_id = @picture.id

    default_palettes = Palette.where(is_default: true)
    user_palettes = Palette.where(user_id: @user_id)
    @palettes = (default_palettes + user_palettes).uniq

    redirect_to editor_path, picture_id: @picture_id if @picture.user != current_user
  end

  def update
    (head :unauthorized) && return unless @picture.user == current_user
    @picture.name = massage_name(params[:name]) if params[:name]
    @picture.palette_id = params[:palette_id] if params[:palette_id]
    if params[:pixels]
      (head :bad_request) && return unless pixels_valid? params[:pixels]
      @picture.add_snapshot(params)
    end
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
