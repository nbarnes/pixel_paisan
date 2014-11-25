class ImagesController < ApplicationController
  include ImagesHelper

  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def create
    respond_to do |format|
      format.json do
        if user_signed_in?
          image = Image.new()
          png = build_png(params[:image_data])
          png.save(params[:name])
          image.png_blob = png.to_blob
          image.png_thumbnail_blob = get_resized_blob(png, 200)
          image.png_display_blob = get_resized_blob(png, 600)
          image.user_id = current_user.id
          image.name = params[:name]
          image.gallery = current_user.galleries[0]
          image.save!

          render json: {
            message: "Image post success",
            status: 200
          }, status: 200
        else
          head :unauthorized
        end
      end
    end
  end

  def destroy
    @image.destroy
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params[:image].permit(:png_data)
    end
end
