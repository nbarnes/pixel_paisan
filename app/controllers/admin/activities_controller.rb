module Admin
  class ActivitiesController < ApplicationController

    before_action :admin_authorize

    def index
      now = Time.now
      @users_created_weekly = User.group_by_day(:created_at, range: now.weeks_ago(4)..now).count
      @snapshots_created_daily = Snapshot.group_by_day(:created_at, range: now.days_ago(6)..now).count
      @snapshots_created_weekly = Snapshot.group_by_week(:created_at, range: now.weeks_ago(3)..now).count
      @snapshots_created_monthly = Snapshot.group_by_month(:created_at, range: now.months_ago(5)..now).count
    end

  end
end
