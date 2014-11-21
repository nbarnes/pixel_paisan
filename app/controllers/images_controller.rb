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
          png = build_png(params[:image_data])
          image = Image.new()
          image.png_data = png.to_blob
          image.user_id = current_user.id
          image.image_name = params[:image_name]
          image.save!
          binding.pry
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
