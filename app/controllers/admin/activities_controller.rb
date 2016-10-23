module Admin
  class ActivitiesController < ApplicationController
    layout 'admin'

    before_action :admin_authorize

    def index
      now = Time.now
      Groupdate.time_zone = 'UTC'

      users_created_daily = User.group_by_day(:created_at, last: 7).count
      users_created_weekly = User.group_by_week(:created_at, last: 4).count
      users_created_monthly = User.group_by_month(:created_at, last: 6).count

      snapshots_created_daily = Snapshot.group_by_day(:created_at, range: now.days_ago(6)..now).count
      snapshots_created_weekly = Snapshot.group_by_week(:created_at, range: now.weeks_ago(3)..now).count
      snapshots_created_monthly = Snapshot.group_by_month(:created_at, range: now.months_ago(5)..now).count

      @created_daily = users_created_daily.map do |users_count|
        [users_count.first, users_count.last, snapshots_created_daily[users_count.first]]
      end.reverse
      @created_weekly = users_created_weekly.map do |users_count|
        [users_count.first, users_count.last, snapshots_created_weekly[users_count.first]]
      end.reverse
      @created_monthly = users_created_monthly.map do |users_count|
        [users_count.first, users_count.last, snapshots_created_monthly[users_count.first]]
      end.reverse
    end

    def show
      timestamp = params[:timestamp].to_datetime
      if params[:period] == 'month'
        @time_identifier = "in #{timestamp.strftime('%B')}"
        @users = User.where(created_at: timestamp.beginning_of_month..timestamp.end_of_month)
        @pictures = Picture.where(snapshot_updated_at: timestamp.beginning_of_month..timestamp.end_of_month).includes(:snapshots, :user)
      elsif params[:period] == 'week'
        @time_identifier = "the week of #{timestamp.strftime('%m/%d')}"
        @users = User.where(created_at: (timestamp.beginning_of_week..timestamp.end_of_week))
        @pictures = Picture.where(snapshot_updated_at: timestamp.beginning_of_week..timestamp.end_of_week).includes(:snapshots, :user)
      else
        @time_identifier = "#{timestamp.strftime('%A')} the #{timestamp.day.ordinalize}"
        @users = User.where(created_at: (timestamp.beginning_of_day..timestamp.end_of_day))
        @pictures = Picture.where(snapshot_updated_at: timestamp.beginning_of_day..timestamp.end_of_day).includes(:snapshots, :user)
      end
    end

  end
end
