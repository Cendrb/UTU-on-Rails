require "net/http"
require "uri"
require "mechanize"
require "nokogiri"

class SummaryController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:post_details]
  skip_before_filter :current_class_check, only: [:welcome_screen, :update]
  before_filter :authenticate_admin, only: [:refresh, :migrate, :temp]
  before_filter :authenticate, only: :subjects

  def summary
    @data = {}
    @data[:service] = {}

    @data[:service][:current] = Service.current
    @data[:articles] = Article.where(published: true).for_class(current_class).order("published_on DESC").limit(3)

    if logged_in?
      @data[:service][:user] = Service.in_future.where("first_mate_id = :class_member OR second_mate_id = :class_member", {class_member: current_user.class_member_id}).first
    end

    DetailsAccess.log_new(current_user, request.remote_ip, request.env['HTTP_USER_AGENT'], 'summary')
  end

  def search
    search_parameters = params[:query]
    sclass = current_class
    @data = {}
    @data[:query] = search_parameters
    @data[:items] = Event.for_class(sclass).order(:event_start).like(search_parameters) + Exam.for_class(sclass).order(:date).like(search_parameters) + Task.for_class(sclass).order(:date).like(search_parameters)
  end

  def post_details
    from = Date.parse(params[:from])
    to = Date.parse(params[:to])
    @events = Event.order(:event_start).between_dates(from, to)
    @exams = Exam.order(:date).for_group(params[:group]).between_dates(from, to)
    @tasks = Task.order(:date).for_group(params[:group]).between_dates(from, to)
    if group != 0
      @exams = @exams.for_group(params[:group])
      @tasks = @tasks.for_group(params[:group])
    end

    DetailsAccess.log_new(current_user, request.remote_ip, request.env['HTTP_USER_AGENT'], 'details')

    render 'details.xml'
  end

  def details
    #from = Date.new(params[:range][:"from(1i)"].to_i, params[:range][:"from(2i)"].to_i, params[:range][:"from(3i)"].to_i)
    #to = Date.new(params[:range][:"to(1i)"].to_i, params[:range][:"to(2i)"].to_i, params[:range][:"to(3i)"].to_i)
    @data = {}

    sclass = current_class
    if logged_in?
      user = current_user

      @data[:events] = Event.order(:event_start).in_future.for_groups(user.sgroups).for_class(sclass) + Article.order("published_on DESC").where(published: true).where(show_in_details: true).where("show_in_details_until > :today", {today: Time.now})
      @data[:exams] = Exam.order(:date).in_future.for_groups(user.sgroups).for_class(sclass).filter_out_todays_after(12)
      @data[:tasks] = Task.order(:date).in_future.for_groups(user.sgroups).for_class(sclass).filter_out_todays_after(12)
      puts Event.all.pluck(:sgroup_id)
    else
      if request.format.symbol == :xml
        # you are deprecated
      else
        @data[:events] = Event.all.order(:event_start).in_future.for_class(sclass)
        @data[:exams] = Exam.order(:date).in_future.for_class(sclass).filter_out_todays_after(12)
        @data[:tasks] = Task.order(:date).in_future.for_class(sclass).filter_out_todays_after(12)
      end
    end

    DetailsAccess.log_new(current_user, request.remote_ip, request.env['HTTP_USER_AGENT'], 'details')

    respond_to do |format|
      format.html
    end
  end

  def service_list
    @services = Service.order(:service_start).in_future
  end

  def subjects
    @subjects = Subject.all
  end

  def administration

  end

  def john_cena

  end

  def update
    if Time.now.hour > 17 && Time.now.hour < 18
      # mark todays tasks and exams as in_past
      SchoolDay.where(date: Date.today).find_each do |day|
        day.lessons.find_each do |lesson|
          lesson.exams.find_each do |exam|
            exam.passed = true
            exam.save!
          end
          lesson.tasks.find_each do |task|
            task.passed = true
            task.save!
          end
        end
      end
    end

    # delete old records
    SchoolDay.destroy_all
    timetables = Timetable.all
    timetables.each do |timetable|
      timetable.get_timetable
    end
    render nothing: true
  end

  def welcome_screen
    render '_unsortables/welcome_screen', layout: false
  end

  def migrate
    # raking lists (add sclass_id)
    # raking entries (migrate from name to class_member_id)
    # users (migrate from name to class_member_id)
    # users (migrate from group to groups-and-belongings-and-stuff)
    # utu_items (add sgroup_id, add sclass_id)
    # planned_raking_entries (wipe)
  end

  private

  def drop_todays_after(items, hour)
    if items
      if Time.now >= (Date.today + hour.hours)
        items.drop_while { |e| e.date == Date.today }
      else
        return items
      end
    end
  end

  def drop_hidden(items)
    items.drop_while { |e| e.is_done? }
  end
end
