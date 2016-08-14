class TimetablesController < ApplicationController
  before_filter :authenticate_admin, except: [:show, :index, :fetch_baka, :fetch_baka_for_all, :summary]
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]
  before_action :set_timetable_from_timetable_id, only: [:fetch_baka, :populate]

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

  def populate
    params[:empty_lesson_chance] ||= 5
    params[:not_normal_lesson_chance] ||= 5
    @timetable.school_days.each do |school_day|
      (1..7).each do |num|
        if rand(params[:empty_lesson_chance]) != 0
          teacher = Teacher.limit(1).order("RANDOM()").first
          subject = Subject.limit(1).order("RANDOM()").first
          not_normal = rand(params[:not_normal_lesson_chance]) == 0
          lesson = school_day.lessons.create(serial_number: num, teacher: teacher, subject: subject, not_normal: not_normal, not_normal_comment: "KANNA")
        end
      end
    end
    redirect_to @timetable
  end

  def fetch_baka
    @timetable.get_timetable
    redirect_to @timetable
  end
  
  def summary
    DetailsAccess.log_new(current_user, request.remote_ip, request.env['HTTP_USER_AGENT'], 'timetable')
    if logged_in?
      @timetables = Timetable.joins("LEFT JOIN group_timetable_bindings ON timetables.id = group_timetable_bindings.timetable_id").joins("LEFT JOIN sgroups ON sgroups.id = group_timetable_bindings.sgroup_id").where("sgroups.id IN (?)", current_user.sgroups.pluck(:id)).where("timetables.sclass_id = ?", current_class.id).uniq
    else
      @timetables = []
      @timetables << Timetable.where(sclass: current_class)
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
