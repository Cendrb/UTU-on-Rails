class ExamsController < ApplicationController
  before_filter :authenticate_admin, except: [:hide, :reveal]
  before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action :set_exam_from_exam_id, only: [:transform_to_task, :hide, :reveal, :snooze, :unsnooze]
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy, :hide, :reveal, :snooze, :unsnooze]
  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.order("date DESC")
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    @exam.group = 0
    @exam.date = next_workday
  end

  # GET /exams/1/edit
  def edit
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new(exam_params)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render action: 'show', status: :created, location: @exam }
        format.whoa { render plain: 'success' }
      else
        format.html { render action: 'new' }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
        format.whoa { render plain: 'fail' }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { head :no_content }
        format.whoa { render plain: 'success' }
      else
        format.html { render action: 'edit' }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
        format.whoa { render plain: 'fail' }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url }
      format.json { head :no_content }
      format.whoa { render plain: 'success' }
    end
  end

  def transform_to_task
    task = @exam.get_task
    Exam.transaction do
      task.save
      @exam.destroy
      redirect_to task, notice: 'Test byl úspešně převeden na úkol a uložen do databáze.'
    end
  end

  def hide
    @exam.mark_as_done

    redirect_back
  end

  def reveal
    @exam.mark_as_undone

    redirect_back
  end
  
  def snooze
     @exam.snooze(params[:date])
    
    redirect_back
  end

  def unsnooze
    @exam.unsnooze

    redirect_back
  end

  private

  def redirect_html_back
    if request.env['HTTP_REFERER']
      redirect_to :back
    else
      redirect_to details_path
    end
  end
  
  def redirect_back
    respond_to do |format|
      format.html { redirect_html_back }
      format.whoa { render plain: "WHOA" }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_exam
    @exam = Exam.find(params[:id])
  end

  def set_exam_from_exam_id
    @exam = Exam.find(params[:exam_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def exam_params
    params.require(:exam).permit(:title, :description, :subject_id, :date, :group, :additional_info_url)
  end
end
