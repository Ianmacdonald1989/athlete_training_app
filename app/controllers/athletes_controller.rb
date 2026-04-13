class AthletesController < ApplicationController
  before_action :set_athlete, only: %i[ show edit update destroy stats ]

  def index
    @athletes = current_user.athletes.includes(:training_sessions)
  end

  def show
    @recent_training_sessions = @athlete.training_sessions.order(date: :desc).limit(5)
  end

  def new
    @athlete = current_user.athletes.new
  end

  def edit
  end

  def create
    @athlete = current_user.athletes.new(athlete_params)

    respond_to do |format|
      if @athlete.save
        format.html { redirect_to @athlete, notice: "Athlete was successfully created." }
        format.json { render :show, status: :created, location: @athlete }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @athlete.update(athlete_params)
        format.html { redirect_to @athlete, notice: "Athlete was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @athlete }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @athlete.destroy!

    respond_to do |format|
      format.html { redirect_to athletes_path, notice: "Athlete was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def stats
    @training_sessions = @athlete.training_sessions.order(date: :desc)

    @total_distance = @training_sessions.sum(:total_distance)
    @average_speed = @training_sessions.average(:average_speed) || 0
  end

  private
    def set_athlete
      @athlete = current_user.athletes.find(params[:id])
    end

    def athlete_params
      params.require(:athlete).permit(:profile, :name, :age, :sport_definition, :email)
    end
end
