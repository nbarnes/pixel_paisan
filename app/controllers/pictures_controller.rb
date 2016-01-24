class PicturesController < ApplicationController

  before_action :set_picture, only: [:show, :update, :destroy, :edit]

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: @picture.as_json
      end
    end
  end

  def destroy
    head :unauthorized unless @picture.user == current_user
    picture_gallery = @picture.gallery
    @picture.destroy
    redirect_to gallery_path(picture_gallery)
  end

  def create
    head :unauthorized unless current_user
    picture = Picture.new
    picture.name = params[:name]
    picture.user_id = current_user.id
    picture.gallery = current_user.galleries[0]
    picture.add_snapshot(params[:pixel_data], params[:cell_size]) if params[:pixel_data]
    picture.save!

    render json: {
      message: "Picture creation success",
      status: 200,
      picture_id: picture.id
    }, status: 200

  end

  def edit
    unless @picture.user == current_user
      @picture = @picture.branch(current_user)
      redirect_to edit_picture_path(@picture)
    end
    @palettes = palettes
  end

  def update
    head :unauthorized unless @picture.user == current_user
    @picture.name = params[:name] if params[:name]
    @picture.add_snapshot(params[:pixel_data], params[:cell_size]) if params[:pixel_data]

    render json: {
      message: "Picture update success",
      status: 200
    }, status: 200

  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params[:picture].permit(:name, :pixel_data)
    end

end
