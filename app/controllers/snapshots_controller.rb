class SnapshotsController < ApplicationController

  before_action :set_snapshot, only: [:show, :destroy]

  def show
  end

  def destroy
    head :unauthorized unless @snapshot.picture.user == current_user
    picture = @snapshot.picture
    @snapshot.destroy
    redirect_to picture
  end

  private
    def set_snapshot
      @snapshot = Snapshot.find(params[:id])
    end

    # Do we really need this if we're never creating via controller action?
    def snapshot_params
      params[:snapshot].permit(:pixels)
    end

end
