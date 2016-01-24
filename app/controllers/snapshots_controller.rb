class SnapshotsController < ApplicationController
  include PngHelper

  before_action :set_snapshot, only: [:show, :destroy]

  def create
    head :unauthorized unless user_signed_in?
    respond_to do |format|
      format.json do

        # snapshot = Snapshot.new()

        # snapshot.picture = picture_for_snapshot
        # snapshot.cell_size = params[:cell_size]
        # # Have to save the snapshot to the database before you save the
        # # PNGs or the Snapshot doesn't have an ID to save the PNGs under
        # snapshot.save!
        # snapshot.save_pngs!(params[:image_data])
        render json: {
          message: "Snapshot post success",
          status: 200,
          picture_id: picture_for_snapshot.id
        }, status: 200

      end
    end
  end

  def destroy
    head :unauthorized unless  @snapshot.picture.user == current_user

    picture = @snapshot.picture
    @snapshot.destroy
    redirect_to picture
  end

  def show
  end

  private
    def set_snapshot
      @snapshot = Snapshot.find(params[:id])
    end

    def snapshot_params
      params[:snapshot].permit(:image_data)
    end
end
