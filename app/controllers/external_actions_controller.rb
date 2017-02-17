class ExternalActionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :current_class_check

  before_filter :check_user_logged_in, only: [:hide_item, :reveal_item]
  before_filter :check_admin_logged_in, only: [:save_item, :destroy_item]
  before_filter :require_id_and_type, only: [:hide_item, :reveal_item, :save_item, :destroy_item]

  # 0 = success
  # 1 = missing parameters
  # 2 = invalid/nonexistent id
  # 3 = invalid item type
  # 4 = ActiveRecord operation error
  # 5 = User required
  # 6 = Insufficient privileges
  # 7 = Login incorrect

  def pre_data
    @data = {}
    @data[:sclasses] = Sclass.all
    @data[:group_categories] = GroupCategory.all
    @data[:subjects] = Subject.all
    @data[:teachers] = Teacher.all
    @data[:lesson_timings] = LessonTiming.all

    render 'pre_data.xml.builder'
  end

  def only_details
    @data = {}
    if params[:sclass_id]
      sclass = Sclass.find(params[:sclass_id])
      @data[:items] = Event.all.order(:event_start).in_future.for_class(sclass) + Exam.order(:date).in_future.for_class(sclass).filter_out_todays_after(12) + Task.order(:date).in_future.for_class(sclass).filter_out_todays_after(12)

      render 'only_details.xml.builder'
    else
      @status_code = 1
      @status_message = 'sclass_id is a required parameter'
      render 'generic_result.xml.builder' and return
    end
  end

  def timetables
    @data = {}
    if params[:sclass_id]
      @data[:timetables] = Timetable.where(sclass_id: params[:sclass_id])
      render 'timetables.xml.builder'
    else
      @status_code = 1
      @status_message = 'sclass_id is a required parameter'
      render 'generic_result.xml.builder' and return
    end
  end

  def data
    @data = {}
    if params[:sclass_id]
      sclass = Sclass.find(params[:sclass_id])
      @data[:current_service] = Service.current

      @data[:events] = Event.all.order('event_start ASC').in_future.for_class(sclass)
      @data[:exams] = Exam.order('date ASC').in_future.for_class(sclass).filter_out_todays_after(12)
      @data[:tasks] = Task.order('date ASC').in_future.for_class(sclass).filter_out_todays_after(12)
      @data[:articles] = Article.order('published_on ASC').limit(10).for_class(sclass)

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

      if !admin_logged_in?
        @data[:articles] = @data[:articles].where(published: true)
      end

      @data[:additional_infos] = AdditionalInfo.for_class(sclass)
      @data[:planned_raking_lists] = PlannedRakingList.for_class(sclass)
      @data[:services] = Service.for_class(sclass).for_school_year(SchoolYear.current).order(:service_start)

      render 'external_actions/data.xml.builder'
    else
      @status_code = 1
      @status_message = 'sclass_id is a required parameter'
      render 'generic_result.xml.builder' and return
    end
  end

  def save_item
    params_motorku = nil
    case params[:type]
      when 'event'
        params_motorku = event_params()
      when 'task'
        params_motorku = task_params()
      when 'written_exam'
        params_motorku = exam_params()
      when 'raking_exam'
        params_motorku = exam_params()
      when 'article'
        params_motorku = article_params()
      else
        @status_code = 3
        @status_message = "Type='#{params[:type]}' is not valid for this action"
        render 'generic_result.xml.builder' and return
    end

    @item = nil
    if params[:exists] == 'true'
      begin
        @item = GenericUtuItem.find_instance(params[:id], params[:type])
        if @item.update(params_motorku)
          if params[:type] == 'event' || params[:type] == 'task' || params[:type] == 'written_exam' || params[:type] == 'raking_exam'
            parse_additional_infos(@item, params[:additional_info_ids])
          end
          render 'show.xml'
        else
          @status_code = 4
          @status_message = "ActiveRecord 'save' (updating) action execution failed for #{params[:type]} with id #{params[:id]}"
          render 'generic_result.xml.builder' and return
        end
      rescue ActiveRecord::RecordNotFound
        @status_code = 2
        @status_message = "Record with id #{params[:id]} was not found"
        render 'generic_result.xml.builder' and return
      rescue ItemTypeInvalidException
        @status_code = 3
        @status_message = "Item type #{params[:type]} was not found"
        render 'generic_result.xml.builder' and return
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
        when 'article'
          @item = Article.new(params_motorku)
        else
          @status_code = 3
          @status_message = "Type='#{params[:type]}' is not valid for this action"
          render 'generic_result.xml.builder' and return
      end
      if @item.save
        # do after save, additional info cannot be bound to nonexistent item
        if params[:type] == 'event' ||
            params[:type] == 'task' ||
            params[:type] == 'written_exam' ||
            params[:type] == 'raking_exam' ||
            params[:type] == 'article'
          parse_additional_infos(@item, params[:additional_info_ids])
        end
        render 'show.xml.builder'
      else
        @status_code = 4
        @status_message = "ActiveRecord 'save' (creating) action execution failed for #{params[:type]}"
        render 'generic_result.xml.builder' and return
      end
    end
  end

  def destroy_item
    begin
      item = GenericUtuItem.find_instance(params[:id], params[:type])
      if item.destroy
        @status_code = 0
        @status_message = "Item #{params[:type]} with id #{params[:id]} was successfully destroyed"
        render 'generic_result.xml.builder' and return
      else
        @status_code = 4
        @status_message = "ActiveRecord 'destroy' action execution failed for #{params[:type]} with id #{params[:id]}"
        render 'generic_result.xml.builder' and return
      end
    rescue ActiveRecord::RecordNotFound
      @status_code = 2
      @status_message = "Record with id #{params[:id]} was not found"
      render 'generic_result.xml.builder' and return
    rescue ItemTypeInvalidException
      @status_code = 3
      @status_message = "Item type #{params[:type]} was not found"
      render 'generic_result.xml.builder' and return
    end
  end

  def hide_item
    if params[:type] != 'event' && params[:type] != 'task' && params[:type] != 'written_exam' && params[:type] != 'raking_exam'
      @status_code = 3
      @status_message = "Type='#{params[:type]}' is not valid for this action"
      render 'generic_result.xml.builder' and return
    end

    begin
      item = GenericUtuItem.find_instance(params[:id], params[:type])
      item.mark_as_done
      @status_code = 0
      @status_message = "Item #{params[:type]} with id #{params[:id]} was successfully hidden"
      render 'generic_result.xml.builder' and return
    rescue ActiveRecord::RecordNotFound
      @status_code = 2
      @status_message = "Record with id #{params[:id]} was not found"
      render 'generic_result.xml.builder' and return
    rescue ItemTypeInvalidException
      @status_code = 3
      @status_message = "Item type #{params[:type]} was not found"
      render 'generic_result.xml.builder' and return
    end
  end

  def reveal_item
    if params[:type] != 'event' && params[:type] != 'task' && params[:type] != 'written_exam' && params[:type] != 'raking_exam'
      @status_code = 3
      @status_message = "Type='#{params[:type]}' is not valid for this action"
      render 'generic_result.xml.builder' and return
    end

    begin
      item = GenericUtuItem.find_instance(params[:id], params[:type])
      item.mark_as_undone
      @status_code = 0
      @status_message = "Item #{params[:type]} with id #{params[:id]} was successfully revealed"
      render 'generic_result.xml.builder' and return
    rescue ActiveRecord::RecordNotFound
      @status_code = 2
      @status_message = "Record with id #{params[:id]} was not found"
      render 'generic_result.xml.builder' and return
    rescue ItemTypeInvalidException
      @status_code = 3
      @status_message = "Item type #{params[:type]} was not found"
      render 'generic_result.xml.builder' and return
    end
  end

  def administrator_logged_in
    render plain: admin_logged_in?
  end

  def opensearch
    response.headers['Content-Type'] = 'application/opensearchdescription+xml; charset=utf-8'
  end

  private
  # @param [GenericUtuItem] generic_utu_item
  def parse_additional_infos(generic_utu_item, additional_infos_string)
    array = YAML.load(additional_infos_string)
    generic_utu_item.info_item_bindings.destroy_all
    infos = AdditionalInfo.find(array)
    infos.each do |info|
      generic_utu_item.info_item_bindings.create!(additional_info_id: info.id)
    end
  end

  def event_params
    params.permit(:title, :description, :location, :event_start, :event_end, :sgroup_id, :sclass_id, :price, :pay_date)
  end

  def exam_params
    params.permit(:title, :description, :subject_id, :date, :sgroup_id, :sclass_id, :passed)
  end

  def task_params
    params.permit(:title, :description, :subject_id, :date, :sgroup_id, :sclass_id, :passed)
  end

  def article_params
    params.permit(:title, :text, :published, :sclass_id, :sgroup_id, :show_in_details_until, :show_in_details)
  end

  def check_user_logged_in
    if !logged_in?
      @status_code = 5
      @status_message = 'User required'
      render 'generic_result.xml.builder'
      return false
    end
    return true
  end

  def check_admin_logged_in
    if !check_user_logged_in
      return false
    end
    if !admin_logged_in?
      @status_code = 6
      @status_message = "Access level of #{User.al_admin} (admin) is required for this action"
      render 'generic_result.xml.builder'
      return false
    end
    return true
  end

  def require_id_and_type
    if params[:id] && params[:type]
      return true
    else
      @status_code = 1
      @status_message = 'Required parameters id and type are missing'
      render 'generic_result.xml.builder'
      return false
    end
  end
end
