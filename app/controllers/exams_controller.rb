class ExamsController < ApplicationController
  include GenericUtuItems
  before_filter :authenticate_admin, except: [:show]
  before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action :set_exam_from_exam_id, only: [:transform_to_task]
  after_action :find_and_set_lesson, only: [:create, :update]

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.order("date DESC").limit(20)
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    @exam.date = next_workday
    new_init(@exam)
  end

  # GET /exams/1/edit
  def edit
    edit_init(@exam)
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new(exam_params)
    update_init(@exam)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url }
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
      format.js
      format.whoa { render plain: "WHOA" }
    end
  end
  
  def find_and_set_lesson
    @exam.find_and_set_lesson
    @exam.save
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
    params.require(:exam).permit(:title, :description, :subject_id, :date, :sgroup_id, :sclass_id, :additional_info_url, :passed)
  end
end
