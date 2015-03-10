require "net/http"
require "uri"
require "mechanize"
require "nokogiri"

class SummaryController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:post_details]
  before_filter :authenticate_admin, only: [:refresh, :migrate, :temp]
  before_filter :authenticate, only: :subjects
  def summary
    @today_school_day = SchoolDay.where("date = ?", Date.tomorrow).first
    
    if logged_in?
      @service = Service.in_future.where("first_name LIKE :user_name OR second_name LIKE :user_name", { user_name: "%#{current_user.name}%"} ).first
    end
    @current_service = Service.where("service_start <= :today AND service_end >= :today", { today: Date.today }).first
    @near_payments = Event.order(:event_start).in_future.where("pay_date <= :pay", { :pay => Date.today + 7.days } ).where("pay_date != event_start")
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

    render 'details.xml'
  end

  def details
    if params[:range] && params[:group]
      from = Date.new(params[:range][:"from(1i)"].to_i,params[:range][:"from(2i)"].to_i,params[:range][:"from(3i)"].to_i)
      to = Date.new(params[:range][:"to(1i)"].to_i,params[:range][:"to(2i)"].to_i,params[:range][:"to(3i)"].to_i)
      @events = Event.order(:event_start).between_dates(from, to)
      @exams = Exam.order(:date).between_dates(from, to)
      @tasks = Task.order(:date).between_dates(from, to)
      if params[:group] != 0
        @exams = @exams.for_group(params[:group])
        @tasks = @tasks.for_group(params[:group])
      end
    else
      if logged_in?
        user = current_user

        @events = Event.all.order(:event_start).in_future
        @exams = Exam.order(:date).in_future.for_group(user.group)
        @tasks = Task.order(:date).in_future.for_group(user.group)

        if request.format.html?
          # Umožnění skrytí jednotlivých položek
          if !user.show_hidden_events
            @events = drop_hidden(@events)
          end
          if !user.show_hidden_exams
            @exams = drop_hidden(@exams)
          end
          if !user.show_hidden_tasks
            @tasks = drop_hidden(@tasks)
          end
        else
          @events = drop_hidden(@events)
          @exams = drop_hidden(@exams)
          @tasks = drop_hidden(@tasks)
        end

        @exams = drop_todays_after(@exams, 12)
        @tasks = drop_todays_after(@tasks, 12)
      else
        @events = (Event.all.order(:event_start)).in_future
        @exams = drop_todays_after(Exam.order(:date).in_future, 12)
        @tasks = drop_todays_after(Task.order(:date).in_future, 12)
      end
    end

    DetailsAccess.log_new(current_user, request.remote_ip, request.env['HTTP_USER_AGENT'])

    respond_to do |format|
      format.html
      format.xml
      format.atom
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

  def update
    if(Time.now.hour > 17 && Time.now.hour < 19)
      # mark todays tasks and exams as in_past
      SchoolDay.where(date: Date.today).find_each do |day|
        day.lessons.find_each do |lesson|
          lesson.exams.find_each do |exam|
            exam.date = 1.day.ago
            exam.save!
          end
          lesson.tasks.find_each do |task|
            task.date = 1.day.ago
            task.save!
          end
        end
      end
    end

    timetables = Timetable.all
    timetables.each do |timetable|
      timetable.get_timetable
    end
    redirect_to :details
  end

  def migrate
    
  end

  def temp
    Exam.in_future.first.find_and_set_lesson
    redirect_to :details
  end

  def administrator_logged_in
    render plain: admin_logged_in?
  end

  private

  def drop_todays_after(items, hour)
    if Time.now >= (Date.today + hour.hours)
      items.drop_while { |e| e.date == Date.today  }
    else
    return items
    end
  end

  def drop_hidden(items)
    items.drop_while { |e| e.is_done? }
  end
end
