class PicturesController < ApplicationController

  before_action :set_picture, only: [:show, :update, :destroy]

  def show
  end

  def create(new_name)
    new_picture = Picture.new
    new_picture.name = name
    new_picture.user = current_user
    new_picture.gallery = current_user.galleries[0]
    new_picture.save!
  end

  def update
  end

  def destroy
    @picture.destroy
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

end
