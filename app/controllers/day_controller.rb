class DayController < ApplicationController
  before_action :authenticate_user!

  def show
    date = Date.parse(params[:date])
    @activity_logs = get_activity_logs_by_date(date)
    render json: @activity_logs
  end

  private
  def get_activity_logs_by_date(date)
    ActivityLog.where(user: current_user).where("started_at >= ? and ended_at < ?", date, date + 1)
  end
end
