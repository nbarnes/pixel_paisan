module Admin
  class UsersController < ApplicationController

    before_action :authorize

    def index
      @users = User.all
      @picture_counts = Picture.joins("LEFT OUTER JOIN users on users.id = pictures.user_id").group("users.id").count("pictures.id")
      @snapshot_counts = Snapshot.joins("LEFT OUTER JOIN pictures on pictures.id = snapshots.picture_id LEFT OUTER JOIN users on pictures.user_id = users.id").group("users.id").count("snapshots.id")
      @last_snapshot_save = Snapshot.joins("LEFT JOIN pictures on pictures.id = snapshots.picture_id LEFT JOIN users on pictures.user_id = users.id").maximum(:created_at)
    end

    private
      def authorize
        redirect_to root_path unless current_user && current_user.admin?
      end

  end
end
