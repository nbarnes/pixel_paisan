class SnapshotsController < ApplicationController
  include SnapshotsHelper

  before_action :set_snapshot, only: [:destroy]

  def create
    respond_to do |format|
      format.json do
        if user_signed_in?
          snapshot = Snapshot.new()

          picture_for_snapshot = Picture.where(name: params[:name])[0]

          if !picture_for_snapshot
            picture_for_snapshot = Picture.new
            picture_for_snapshot.name = params[:name]
            picture_for_snapshot.user_id = current_user.id
            picture_for_snapshot.gallery = current_user.galleries[0]
            picture_for_snapshot.save!
          end

          snapshot.picture = picture_for_snapshot
          snapshot.save_pngs(params[:image_data])
          snapshot.save!


          render json: {
            message: "Snapshot post success",
            status: 200
          }, status: 200
        else
          head :unauthorized
        end
      end
    end
  end

  def edit

  end

  def destroy
  end

  private
    def set_snapshot
      @snapshot = Snapshot.find(params[:id])
    end

    def snapshot_params
      params[:snapshot].permit(:png_data)
    end
end