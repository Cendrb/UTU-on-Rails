class SchoolDaysController < ApplicationController
  before_filter :authenticate_admin
  before_action :set_school_day, only: [:show, :edit, :update, :destroy]
  # GET /school_days
  # GET /school_days.json
  def index
    @school_days = SchoolDay.all
  end

  # GET /school_days/1
  # GET /school_days/1.json
  def show
    
  end

  # GET /school_days/new
  def new
    @school_day = SchoolDay.new
  end

  # GET /school_days/1/edit
  def edit
  end

  # POST /school_days
  # POST /school_days.json
  def create
    @school_day = SchoolDay.new(school_day_params)

    respond_to do |format|
      if @school_day.save
        format.html { redirect_to @school_day, notice: 'School day was successfully created.' }
        format.json { render :show, status: :created, location: @school_day }
      else
        format.html { render :new }
        format.json { render json: @school_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /school_days/1
  # PATCH/PUT /school_days/1.json
  def update
    respond_to do |format|
      if @school_day.update(school_day_params)
        format.html { redirect_to @school_day, notice: 'School day was successfully updated.' }
        format.json { render :show, status: :ok, location: @school_day }
      else
        format.html { render :edit }
        format.json { render json: @school_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_days/1
  # DELETE /school_days/1.json
  def destroy
    @school_day.destroy
    respond_to do |format|
      format.html { redirect_to school_days_url, notice: 'School day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_school_day
    @school_day = SchoolDay.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def school_day_params
    params.require(:school_day).permit(:date, :weekday)
  end
end
