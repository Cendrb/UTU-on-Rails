class WrittenExamsController < ApplicationController
  include GenericUtuItems

  before_filter :authenticate_admin, except: [:show]
  before_action :set_written_exam, only: [:show, :edit, :update, :destroy]
  after_action :find_and_set_lesson, only: [:create, :update]
  before_action :set_written_exam_from_written_exam_id, only: [:transform_to_raking]

  # GET /written_exams
  # GET /written_exams.json
  def index
    @written_exams = WrittenExam.order(:date)
  end

  # GET /written_exams/1
  # GET /written_exams/1.json
  def show
  end

  # GET /written_exams/new
  def new
    @written_exam = WrittenExam.new
    @written_exam.date = next_workday
    new_init(@written_exam)
  end

  # GET /written_exams/1/edit
  def edit
    edit_init(@written_exam)
  end

  # POST /written_exams
  # POST /written_exams.json
  def create
    @written_exam = WrittenExam.new(written_exam_params)
    update_init(@written_exam)

    respond_to do |format|
      if @written_exam.save
        format.html { redirect_to @written_exam, notice: 'Written exam was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /written_exams/1
  # PATCH/PUT /written_exams/1.json
  def update
    update_init(@written_exam)
    respond_to do |format|
      if @written_exam.update(written_exam_params)
        format.html { redirect_to @written_exam, notice: 'Written exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @written_exam }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /written_exams/1
  # DELETE /written_exams/1.json
  def destroy
    @written_exam.destroy
    respond_to do |format|
      format.html { redirect_to written_exams_url, notice: 'Written exam was successfully destroyed.' }
    end
  end
  
  def transform_to_raking
    @written_exam.type = "RakingExam"
    @written_exam.end_date = @written_exam.date
    @written_exam.save!
    
    @written_exam.find_and_set_lesson
    
    redirect_to @written_exam
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_written_exam
      @written_exam = WrittenExam.find(params[:id])
    end
    
    def find_and_set_lesson
      @written_exam.find_and_set_lesson
      @written_exam.save!
    end
    
    def set_written_exam_from_written_exam_id
      @written_exam = WrittenExam.find(params[:written_exam_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def written_exam_params
      params[:written_exam].permit(:title, :description, :subject_id, :date, :sgroup_id, :sclass_id, :additional_info_url, :passed)
    end
end
