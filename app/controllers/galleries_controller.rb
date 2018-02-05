class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show]

  def index
    @galleries = Gallery.eager_load(:user, pictures: :snapshots).all
  end

  def show; end

  private
    def set_gallery
      @gallery = Gallery.eager_load(pictures: :snapshots).find(params[:id])
    end

    def gallery_params
      params[:gallery]
    end

end
