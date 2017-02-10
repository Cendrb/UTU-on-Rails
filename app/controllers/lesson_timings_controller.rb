class LessonTimingsController < ApplicationController
  before_filter :authenticate_admin
  before_action :set_lesson_timing, only: [:edit, :update, :destroy]

  # GET /lesson_timings
  def index
    @lesson_timings = LessonTiming.all
  end

  # GET /lesson_timings/new
  def new
    @lesson_timing = LessonTiming.new
  end

  # GET /lesson_timings/1/edit
  def edit
  end

  # POST /lesson_timings
  # POST /lesson_timings.json
  def create
    @lesson_timing = LessonTiming.new()

    respond_to do |format|
      if @lesson_timing.save
        format.html { redirect_to @lesson_timing, notice: 'Lesson timing was successfully created.' }
        format.json { render :index, status: :created, location: @lesson_timing }
      else
        format.html { render :new }
        format.json { render json: @lesson_timing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lesson_timings/1
  # PATCH/PUT /lesson_timings/1.json
  def update
    respond_to do |format|
      if @lesson_timing.update(lesson_timing_params)
        format.html { redirect_to @lesson_timing, notice: 'Lesson timing was successfully updated.' }
        format.json { render :index, status: :ok, location: @lesson_timing }
      else
        format.html { render :edit }
        format.json { render json: @lesson_timing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_timings/1
  # DELETE /lesson_timings/1.json
  def destroy
    @lesson_timing.destroy
    respond_to do |format|
      format.html { redirect_to lesson_timings_url, notice: 'Lesson timing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_timing
      @lesson_timing = LessonTiming.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_timing_params
      params.require(:lesson_timing).permit(:start, :duration, :serial_number)
    end
end
