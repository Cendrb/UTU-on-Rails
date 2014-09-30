class DayTeachersController < ApplicationController
  before_filter :authenticate_admin, except: [:new, :create]
  before_filter :authenticate, only: [:new, :create]
  before_action :set_day_teacher, only: [:show, :edit, :update, :destroy]
  before_action :set_teachers_list_variable, only: [:edit, :new, :create]
  # GET /day_teachers
  # GET /day_teachers.json
  def index
    @day_teachers = DayTeacher.all
  end

  # GET /day_teachers/1
  # GET /day_teachers/1.json
  def show
  end
  
  def results
    
  end

  # GET /day_teachers/new
  def new
    @day_teacher = DayTeacher.new
  end

  # GET /day_teachers/1/edit
  def edit

  end

  # POST /day_teachers
  # POST /day_teachers.json
  def create
    @day_teacher = DayTeacher.new(day_teacher_params)
    @day_teacher.date = Date.today
    @day_teacher.user = current_user
    
    today_user_teachers = DayTeacher.where("date = :today AND user_id = :user", { today: Date.today, user: current_user } )

    if(today_user_teachers.count > 0)
      redirect_to :vote, alert: 'Můžete hlasovat pouze jednou denně.'
      return
    end

    if @day_teacher.save
      redirect_to :vote, notice: 'Váš hlas byl zaznamenán.'
    else
      redirect_to :root, alert: "Váš hlas se nepodařilo uložit."
    end
  end

  # PATCH/PUT /day_teachers/1
  # PATCH/PUT /day_teachers/1.json
  def update
    respond_to do |format|
      if @day_teacher.update(day_teacher_params)
        format.html { redirect_to @day_teacher, notice: 'Kurva dně byla úspěšně aktualizována.' }
        format.json { render :show, status: :ok, location: @day_teacher }
      else
        format.html { render :edit }
        format.json { render json: @day_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_teachers/1
  # DELETE /day_teachers/1.json
  def destroy
    @day_teacher.destroy
    respond_to do |format|
      format.html { redirect_to day_teachers_url, notice: 'Day teacher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_teachers_list_variable
    @teachers = Teacher.for_group(current_user.group)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_day_teacher
    @day_teacher = DayTeacher.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def day_teacher_params
    params.require(:day_teacher).permit(:date, :teacher_id)
  end
end
