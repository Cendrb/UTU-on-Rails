class ExternalActionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :current_class_check
  before_filter :authenticate_admin, only: [:save_item, :destroy_item]

  def pre_data
    @data = {}
    @data[:sclasses] = Sclass.all
    @data[:group_categories] = GroupCategory.all
    @data[:subjects] = Subject.all

    render 'pre_data.xml'
  end

  def only_details
    @data = {}
    if params[:sclass_id]
      sclass = Sclass.find(params[:sclass_id])
      @data[:items] = Event.all.order(:event_start).in_future.for_class(sclass) + Exam.order(:date).in_future.for_class(sclass).filter_out_todays_after(12) + Task.order(:date).in_future.for_class(sclass).filter_out_todays_after(12)

      render 'only_details.xml'
    else
      render plain: 'Required params: sclass_id'
    end
  end

  def timetables
    @data = {}
    if params[:sclass_id]
      @data[:timetables] = Timetable.where(sclass_id: params[:sclass_id])
      render 'timetables.xml'
    else
      render plain: 'Required params: sclass_id'
    end
  end

  def data
    @data = {}
    if params[:sclass_id]
      sclass = Sclass.find(params[:sclass_id])
      @data[:events] = Event.all.order('event_start ASC').in_future.for_class(sclass)
      @data[:exams] = Exam.order('date ASC').in_future.for_class(sclass).filter_out_todays_after(12)
      @data[:tasks] = Task.order('date ASC').in_future.for_class(sclass).filter_out_todays_after(12)
      @data[:articles] = Article.where(published: true).order("published_on DESC").limit(10).for_class(sclass)

      if params[:group_ids]
        @data[:events] = @data[:events].for_group_ids(params[:group_ids])
        @data[:exams] = @data[:exams].for_group_ids(params[:group_ids])
        @data[:tasks] = @data[:tasks].for_group_ids(params[:group_ids])
        @data[:articles] = @data[:articles].for_group_ids(params[:group_ids])
      end
      if logged_in?
        user = current_user
        @data[:events] = @data[:events].for_groups(user.sgroups)
        @data[:exams] = @data[:exams].for_groups(user.sgroups)
        @data[:tasks] = @data[:tasks].for_groups(user.sgroups)
        @data[:articles] = @data[:articles].for_groups(user.sgroups)
      end

      @data[:additional_infos] = AdditionalInfo.all

      render 'data.xml'
    else
      render plain: 'Required params: sclass_id; Optional params: group_ids'
    end
  end

  def save_item
    params_motorku = nil
    case params[:type]
      when 'event'
        params_motorku = event_params
      when 'task'
        params_motorku = task_params
      when 'written_exam'
        params_motorku = exam_params
      when 'raking_exam'
        params_motorku = exam_params
    end

    @item = nil
    if params[:exists] == 'true'
      @item = GenericUtuItem.find_instance(params[:id], params[:type])
      if @item.update(params_motorku)
        render 'show.xml'
      else
        render plain: GenericUtuItem.failure_string
      end
    else
      case params[:type]
        when 'event'
          @item = Event.new(params_motorku)
        when 'task'
          @item = Task.new(params_motorku)
        when 'written_exam'
          @item = WrittenExam.new(params_motorku)
        when 'raking_exam'
          @item = RakingExam.new(params_motorku)
      end
      if @item.save
        render 'show.xml'
      else
        render plain: GenericUtuItem.failure_string
      end
    end
  end

  def destroy_item
    item = GenericUtuItem.find_instance(params[:id], params[:type])
    if item
      if item.destroy
        render plain: GenericUtuItem.success_string
      else
        render plain: GenericUtuItem.failure_string
      end
    else
      render plain: GenericUtuItem.failure_string
    end
  end

  def administrator_logged_in
    render plain: admin_logged_in?
  end

  def opensearch
    response.headers['Content-Type'] = 'application/opensearchdescription+xml; charset=utf-8'
  end

  private
  def event_params
    params.permit(:title, :description, :location, :event_start, :event_end, :sgroup_id, :sclass_id, :additional_info_url, :price, :pay_date)
  end

  def exam_params
    params.permit(:title, :description, :subject_id, :date, :sgroup_id, :sclass_id, :additional_info_url, :passed)
  end

  def task_params
    params.permit(:title, :description, :subject_id, :date, :sgroup_id, :sclass_id, :additional_info_url, :passed)
  end

end
