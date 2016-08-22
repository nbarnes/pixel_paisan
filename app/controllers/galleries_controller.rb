class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show]

  def index
    @galleries = Gallery.all

  end

  def show
  end

  private
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    def gallery_params
      params[:gallery]
    end

end
