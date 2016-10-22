module Admin
  class UsersController < ApplicationController
    layout 'admin'

    before_action :admin_authorize

    def index
      @users = User.all
      @picture_counts = User.joins(:pictures).group('users.id').count('pictures.id')
      @snapshot_counts = Snapshot.joins(picture: :user).group('users.id').count('snapshots.id')
      @most_recently_saved_snapshots = Snapshot.joins(picture: :user).group('users.id').maximum('snapshots.created_at')
      @recent_snapshot_counts = Snapshot
                                .joins(picture: :user)
                                .where('snapshots.created_at > ? AND snapshots.created_at < ?', Time.now.weeks_ago(1), Time.now)
                                .group('users.id')
                                .count('snapshots.id')
    end

    def show
      @user = User.includes(:pictures).find(params[:id])
      @pictures_count = @user.pictures.size
      @snapshots_count = @user.pictures.inject(0) do |sum, picture|
        sum + picture.snapshots.size
      end
      @recent_snapshots_count = Snapshot.joins(picture: :user)
                                        .where(users: { id: params[:id] })
                                        .order(:created_at)
                                        .created_between(Time.now.days_ago(6), Time.now)
                                        .count
      @recent_snapshots = Snapshot.joins(picture: :user).where(users: { id: params[:id] }).order(:created_at).limit 10
    end

  end
end
