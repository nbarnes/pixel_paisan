class PicturesController < ApplicationController

  before_action :set_picture, only: [:show, :destroy]

  def show
  end

  def destroy
    @picture.destroy
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

end
