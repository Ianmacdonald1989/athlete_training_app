class TrainingSessionsController < ApplicationController
  before_action :set_athlete
  def new
    @training_session = @athlete.training_sessions.new
  end

  def create
    @training_sessions = @athlete.training_sessions.new(training_session_params)
    if @training_session.save
      redirect_to syntax_athlete_path(@athlete), notice: "Training session added!"
    else
      render :new
    end
  end

  private

  def set_athlete
    @athlete = Athlete.find(params[:athlete_id])
  end

  def training_session_params
    params.require(:training_Session).permit(:start_time, :finish_time, :average_speed, :total_distance, :date)
  end
end
