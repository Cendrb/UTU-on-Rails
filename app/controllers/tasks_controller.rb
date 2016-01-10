class TasksController < ApplicationController
  before_filter :authenticate_admin, except: [:hide, :reveal]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_task_from_task_id, only: [:transform_to_exam, :hide, :reveal]
  after_action :find_and_set_lesson, only: [:create, :update]
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy, :hide, :reveal]
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.order("date DESC")
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.date = next_workday
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.whoa { render plain: 'success' }
      else
        format.html { render action: 'new' }
        format.whoa { render plain: 'fail' }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.whoa { render plain: 'success' }
      else
        format.html { render action: 'edit' }
        format.whoa { render plain: 'fail' }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.whoa { render plain: 'success' }
    end
  end

  def transform_to_exam
    type = params[:type] == 'raking_exam' ? 'RakingExam' : 'WrittenExam'
    exam = @task.get_exam(type)
    Task.transaction do
      exam.save
      @task.destroy
      redirect_to exam, notice: 'Úkol byl úspešně převeden na test a uložen do databáze.'
    end
  end

  def hide
    @task.mark_as_done
    
    redirect_back
  end

  def reveal
    @task.mark_as_undone
    
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
      format.js
      format.whoa { render plain: "WHOA" }
    end
  end
  
  def find_and_set_lesson
    @task.find_and_set_lesson
    @task.save!
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end
  
  def set_task_from_task_id
    @task = Task.find(params[:task_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:title, :description, :subject_id, :date, :sgroup_id, :sclass_id, :additional_info_url, :passed)
  end
end
