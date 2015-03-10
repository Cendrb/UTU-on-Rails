class TimetablesController < ApplicationController
  before_filter :authenticate_admin, except: [:show, :index, :fetch_baka, :fetch_baka_for_all, :summary]
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
    respond_to do |format|
      format.html
      format.js
    end
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
  
  def summary
    if logged_in?
      @timetable = Timetable.where(group: current_user.group).first
    else
      @first_group_timetable = Timetable.find_by_group(1)
      @second_group_timetable = Timetable.find_by_group(2)
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
      params.require(:timetable).permit(:name, :baka_account_id, :group)
    end
end
