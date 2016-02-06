class ExternalActionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :current_class_check

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
      render plain: 'How did you end up here?!'
    end
  end

  def data
    @data = {}
    if params[:sclass_id]
      sclass = Sclass.find(params[:sclass_id])
      @data[:events] = Event.all.order(:event_start).in_future.for_class(sclass)
      @data[:exams] = Exam.order(:date).in_future.for_class(sclass).filter_out_todays_after(12)
      @data[:tasks] = Task.order(:date).in_future.for_class(sclass).filter_out_todays_after(12)

      if params[:group_ids]
        @data[:events] = @data[:events].for_group_ids(params[:group_ids])
        @data[:exams] = @data[:exams].for_group_ids(params[:group_ids])
        @data[:tasks] = @data[:tasks].for_group_ids(params[:group_ids])
      end

      @data[:additional_infos] = AdditionalInfo.all

      render 'data.xml'
    else
      render plain: 'How did you end up here?!'
    end
  end

  def opensearch
    response.headers['Content-Type'] = 'application/opensearchdescription+xml; charset=utf-8'
  end
end
