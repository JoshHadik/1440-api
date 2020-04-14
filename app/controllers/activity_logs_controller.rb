class ActivityLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_allow_owner!, only: [
    :show, :update, :destroy
  ]



  # GET /activity_logs
  # def index
  #   if params[:date]
  #     datetime = DateTime.parse(params[:date])
  #   else
  #     datetime = DateTime.now
  #   end
  #
  #   @activity_logs = ActivityLog.all.where()
  #
  #   render json: @activity_logs
  # end

  # GET /activity_logs/1
  def show
    render json: current_activity_log
  end

  # POST /activity_logs
  def create
    @activity_log = ActivityLog.new(activity_log_params)
    @activity_log.user = current_user if current_user

    if @activity_log.save
      render json: @activity_log, status: :created, location: @activity_log
    else
      render json: @activity_log.errors, status: :unprocessable_entity
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
end
