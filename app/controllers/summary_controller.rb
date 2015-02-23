require "net/http"
require "uri"
require "mechanize"
require "nokogiri"

class SummaryController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:post_details]
  before_filter :authenticate_admin, only: [:refresh, :migrate]
  before_filter :authenticate, only: :subjects
  def summary
    if logged_in?
      user_names = current_user.name.split
      services = Service.in_future
      services.each do |service|
        user_names.each do |user_name|
          if service.first_name.include?(user_name) || service.second_name.include?(user_name)
            @service = service
            @error = nil
            return "penis"
          else
            @error = "Vaše příjmení není v záznamech o službách.\nBuď již te  nto rok nemáte službu nebo vaše jméno není platné (porovnáváno příjmení aktuálně přihlášeného uživatele a jméno ve službách)"
          end
        end
      end
    end
    @near_payments = Event.order(:event_start).in_future.where("pay_date <= :pay", { :pay => Date.today + 7.days } )
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
        end

        @exams = drop_todays_after(@exams, 12)
        @tasks = drop_todays_after(@tasks, 12)
      else
        @events = (Event.all.order(:event_start)).in_future
        @exams = drop_todays_after(Exam.order(:date).in_future, 12)
        @tasks = drop_todays_after(Task.order(:date).in_future, 12)
      end
    end

    if(!current_user.nil? && !current_user.email == "penis@penis.com")
      DetailsAccess.log_new(current_user, request.remote_ip, request.env['HTTP_USER_AGENT'])
    end

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

  def migrate
    User.all.each do |user|
      user.hidden_events.each do |i|
        DoneEvent.create(user: user, event_id: i)
      end
      user.hidden_exams.each do |i|
        DoneExam.create(user: user, exam_id: i)
      end
      user.hidden_tasks.each do |i|
        DoneTask.create(user: user, task_id: i)
      end
    end
  end

  def administrator_logged_in
    render plain: admin_logged_in?
  end

  def refresh_baka
    timetables = Timetable.all
    timetables.each do |timetable|
      timetable.get_timetable
    end
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
