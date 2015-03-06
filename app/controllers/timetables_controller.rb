class TimetablesController < ApplicationController
  before_filter :authenticate_admin, except: [:show, :index, :fetch_baka, :fetch_baka_for_all]
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]
  before_action :set_timetable_from_timetable_id, only: [:fetch_baka]

  # GET /timetables
  # GET /timetables.json
  def index
    @timetables = Timetable.all
  end

  # GET /timetables/1
  # GET /timetables/1.json
  def show
    current_date = Date.today
    puts "\n\n\n" + current_date.beginning_of_week.to_s + " " + current_date.end_of_week.to_s
    @current_week_days = @timetable.school_days.where("date >= :min AND date <= :max", { min: current_date.beginning_of_week, max: current_date.end_of_week } )
    
    next_week_date = Date.today + 1.week
    @next_week_days = @timetable.school_days.where("date >= :min AND date <= :max", { min: next_week_date.beginning_of_week, max: next_week_date.end_of_week } )
  end

  # GET /timetables/new
  def new
    @timetable = Timetable.new
  end

  # GET /timetables/1/edit
  def edit
  end

  # POST /timetables
  # POST /timetables.json
  def create
    @timetable = Timetable.new(timetable_params)

    respond_to do |format|
      if @timetable.save
        format.html { redirect_to @timetable, notice: 'Timetable was successfully created.' }
        format.json { render :show, status: :created, location: @timetable }
      else
        format.html { render :new }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timetables/1
  # PATCH/PUT /timetables/1.json
  def update
    respond_to do |format|
      if @timetable.update(timetable_params)
        format.html { redirect_to @timetable, notice: 'Timetable was successfully updated.' }
        format.json { render :show, status: :ok, location: @timetable }
      else
        format.html { render :edit }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timetables/1
  # DELETE /timetables/1.json
  def destroy
    @timetable.destroy
    respond_to do |format|
      format.html { redirect_to timetables_url, notice: 'Timetable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fetch_baka
    @timetable.get_timetable
    redirect_to @timetable
  end
  
    def fetch_baka_for_all
    timetables = Timetable.all
    timetables.each do |timetable|
      timetable.get_timetable
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_timetable
      @timetable = Timetable.find(params[:id])
    end
    
    def set_timetable_from_timetable_id
      @timetable = Timetable.find(params[:timetable_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timetable_params
      params.require(:timetable).permit(:name, :baka_account_id)
    end
end
