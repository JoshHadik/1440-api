class ActivityLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_allow_owner!, only: [
    :show, :update, :destroy
  ]



  # GET /activity_logs
  def index
    @activity_logs = ActivityLog.all

    render json: @activity_logs
  end

  # GET /activity_logs/1
  def show
    render json: current_activity_log
  end

  # POST /activity_logs
  def create
    new_activity_log = ActivityLog.new(activity_log_params)
    new_activity_log.user = current_user if current_user

    if new_activity_log.save
      render json: new_activity_log, status: :created, location: new_activity_log
    else
      render json: new_activity_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activity_logs/1
  def update
    if current_activity_log.update(activity_log_params)
      render json: current_activity_log
    else
      render json: current_activity_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activity_logs/1
  def destroy
    current_activity_log.destroy
  end

  private
    # Only allow a trusted parameter "white list" through.
    def activity_log_params
      params.require(:activity_log).permit(:started_at, :ended_at, :label)
    end

    def only_allow_owner!
      unless current_activity_log.user == current_user
        render :json, status: :unauthorized
      end
    end

    def current_activity_log
      @activity_log ||= ActivityLog.find(params[:id])
    end

    def new_activity_log(with: {})
      @activity_log ||= ActivityLog.new(with)
    end
end
