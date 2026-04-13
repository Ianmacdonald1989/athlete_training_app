class TrainingSessionsController < ApplicationController
  before_action :set_athlete
  def new
    @training_session = @athlete.training_sessions.new(date: Date.current)
  end

  def create
    @training_session = @athlete.training_sessions.new(training_session_params)
    if @training_session.save
      redirect_to athlete_path(@athlete), notice: "Training session added!"
    else
      render :new
    end
  end

  private

  def set_athlete
    @athlete = current_user.athletes.find(params[:athlete_id])
  end

  def training_session_params
    params.require(:training_session).permit(:start_time, :finish_time, :average_speed, :total_distance, :date)
  end
end
