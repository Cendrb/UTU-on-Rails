require "net/http"
require "uri"
require "mechanize"
require "nokogiri"

class SummaryController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:post_details]
  before_filter :authenticate_admin, only: [:refresh, :migrate, :temp]
  before_filter :authenticate, only: :subjects

  def summary
    @data = {}
    @data[:service] = {}
    @data[:rakings] = {}

    @data[:service][:current] = Service.where("service_start <= :today AND service_end >= :today", {today: Date.today}).first
    @data[:articles] = Article.where(published: true).order("published_on DESC").limit(3)

    if logged_in?
      @data[:service][:user] = Service.in_future.where("first_mate_id = :class_member OR second_mate_id = :class_member", {class_member: current_user.class_member_id}).first

      @data[:rakings][:chances] = []
      PlannedRakingList.where(sclass: current_class).where(planned: false).each do |list|
        if list.current_round.planned_raking_entries.where(class_member_id: current_user.class_member).count == 0
          @data[:rakings][:chances] << {name: list.title, chance: (list.rekt_per_hour.to_f / list.current_round.not_rekt_yet_count.to_f) * 100, already_rekt: list.current_round.already_rekt_count, total: list.sclass.class_members.count}
        end
      end
    end
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
    #from = Date.new(params[:range][:"from(1i)"].to_i, params[:range][:"from(2i)"].to_i, params[:range][:"from(3i)"].to_i)
    #to = Date.new(params[:range][:"to(1i)"].to_i, params[:range][:"to(2i)"].to_i, params[:range][:"to(3i)"].to_i)
    sclass = current_class
    if logged_in?
      user = current_user

      @events = Event.order(:event_start).in_future.for_groups(user.sgroups).for_class(sclass) + Article.where(published: true).where(show_in_details: true).where("show_in_details_until > :today", {today: Time.now})
      @exams = Exam.order(:date).in_future.for_groups(user.sgroups).for_class(sclass)
      @tasks = Task.order(:date).in_future.for_groups(user.sgroups).for_class(sclass)
      puts Event.all.pluck(:sgroup_id)

      @exams = drop_todays_after(@exams, 12)
      @tasks = drop_todays_after(@tasks, 12)
    else
      @events = (Event.all.order(:event_start)).in_future.for_class(sclass)
      @exams = drop_todays_after(Exam.order(:date).in_future.for_class(sclass), 12)
      @tasks = drop_todays_after(Task.order(:date).in_future.for_class(sclass), 12)
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
    if (Time.now.hour > 17 && Time.now.hour < 19)
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

    timetables = Timetable.all
    timetables.each do |timetable|
      timetable.get_timetable
    end
    render nothing: true
  end

  def migrate
    # raking lists (add sclass_id)
    # raking entries (migrate from name to class_member_id)
    # users (migrate from name to class_member_id)
    # users (migrate from group to groups-and-belongings-and-stuff)
    # utu_items (add sgroup_id, add sclass_id)
    # planned_raking_entries (wipe)
  end

  def administrator_logged_in
    render plain: admin_logged_in?
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
