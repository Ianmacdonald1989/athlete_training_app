class AthletesController < ApplicationController
  before_action :set_athlete, only: %i[ show edit update destroy ]

  # GET /athletes or /athletes.json
  def index
    @athletes = Athlete.all
  end

  # GET /athletes/1 or /athletes/1.json
  def show
    @athlete = Athlete.find(params[:id])
  end

  # GET /athletes/new
  def new
    @athlete = Athlete.new
  end

  # GET /athletes/1/edit
  def edit
  end

  # POST /athletes or /athletes.json
  def create
    @athlete = Athlete.new(athlete_params)

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

  # PATCH/PUT /athletes/1 or /athletes/1.json
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

  # DELETE /athletes/1 or /athletes/1.json
  def destroy
    @athlete.destroy!

    respond_to do |format|
      format.html { redirect_to athletes_path, notice: "Athlete was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def stats
    @athlete = Athlete.find(params[:id])
    @training_sessions = @athlete.training_sessions.order(date: :desc)

    total_distance = @training_sessions.sum(:total_distance)

    sessions_with_times = @training_sessions.select { |s| s.start_time.present? && s.finish_time.present? }
    total_hours = sessions_with_times.sum do |session|
      ((session.finish_time - session.start_time) / 1.hour).to_f
    end

    @total_distance = total_distance
    @average_speed = if total_hours.positive?
                       total_distance / total_hours
                     else
                       0
                     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_athlete
      @athlete = Athlete.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def athlete_params
      params.require(:athlete).permit(:profile, :name, :age, :sport_definition, :email)
    end
end
