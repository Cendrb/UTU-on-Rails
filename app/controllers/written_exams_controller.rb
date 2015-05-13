class WrittenExamsController < ApplicationController
  before_filter :authenticate_admin, except: [:show]
  before_action :set_written_exam, only: [:show, :edit, :update, :destroy]
  after_action :find_and_set_lesson, only: [:create, :update]

  # GET /written_exams
  # GET /written_exams.json
  def index
    @written_exams = WrittenExam.all
  end

  # GET /written_exams/1
  # GET /written_exams/1.json
  def show
  end

  # GET /written_exams/new
  def new
    @written_exam = WrittenExam.new
    @written_exam.date = next_workday
    @written_exam.group = 0
  end

  # GET /written_exams/1/edit
  def edit
  end

  # POST /written_exams
  # POST /written_exams.json
  def create
    @written_exam = WrittenExam.new(written_exam_params)

    respond_to do |format|
      if @written_exam.save
        format.html { redirect_to @written_exam, notice: 'Written exam was successfully created.' }
        format.json { render :show, status: :created, location: @written_exam }
      else
        format.html { render :new }
        format.json { render json: @written_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /written_exams/1
  # PATCH/PUT /written_exams/1.json
  def update
    respond_to do |format|
      if @written_exam.update(written_exam_params)
        format.html { redirect_to @written_exam, notice: 'Written exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @written_exam }
      else
        format.html { render :edit }
        format.json { render json: @written_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /written_exams/1
  # DELETE /written_exams/1.json
  def destroy
    @written_exam.destroy
    respond_to do |format|
      format.html { redirect_to written_exams_url, notice: 'Written exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_written_exam
      @written_exam = WrittenExam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def written_exam_params
      params[:written_exam].permit(:title, :description, :subject_id, :date, :group, :additional_info_url)
    end
end
