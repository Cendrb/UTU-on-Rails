require "net/http"
require "uri"

require "mechanize"
require "nokogiri"

class SummaryController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:post_details]
  before_filter :authenticate_admin, only: :refresh
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
            @error = "Vaše příjmení není v záznamech o službách.\nBuď již tento rok nemáte službu nebo vaše jméno není platné (porovnáváno příjmení aktuálně přihlášeného uživatele a jméno ve službách)"
          end
        end
      end
    end
    @near_payments = Event.order(:event_start).in_future.where("pay_date <= :pay AND pay_date != event_start", { :pay => Date.today + 7.days } )
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

        # Umožnění skrytí jednotlivých položek
        if !user.show_hidden_events
          @events = @events.id_not_on_list(user.hidden_events) if user.hidden_events.length > 0
        end
        if !user.show_hidden_exams
          @exams = @exams.id_not_on_list(user.hidden_exams) if user.hidden_exams.length > 0
        end
        if !user.show_hidden_tasks
          @tasks = @tasks.id_not_on_list(user.hidden_tasks) if user.hidden_tasks.length > 0
        end

        @exams = drop_todays_after(@exams, 12)
        @tasks = drop_todays_after(@tasks, 12)
      else
        @events = (Event.all.order(:event_start)).in_future
        @exams = drop_todays_after(Exam.order(:date).in_future, 12)
        @tasks = drop_todays_after(Task.order(:date).in_future, 12)
      end
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

  def administration

  end

  def convert_to_DB_items
    exams = Exam.all
    exams.each do |exam|
      exam.subject_id = Subject.find_by_name(exam.subject).id
      exam.save!
    end
    tasks = Task.all
    tasks.each do |task|
      task.subject_id = Subject.find_by_name(task.subject).id
      task.save!
    end
  end

  def refresh_baka
    browser = Mechanize.new
    
    page = browser.get('http://84.42.144.180/bakaweb/login.aspx')
    
    page.encoding = 'utf-8'
    
    form = page.forms.first
    form["ctl00$cphmain$Loginname"] = "980728kjfm"
    form["ctl00$cphmain$TextBoxHeslo"] = "91ipams1"
    form["ctl00$cphmain$ButtonPrihlas"] = "Přihlásit"
    form["__EVENTTARGET"] = ""
    form["__EVENTARGUMENT"] = ""
    form["ctl00$cphmain$Loginname1"] = ""
    form["ctl00$cphmain$Loginname2"] = ""
    
    page = form.submit(form.buttons.first)
    
    page = browser.click(page.link_with(text: /Rozvrh/))
    
    primary_timetable = Timetable.find_by_name("primary")
    
    parse_timetable_from_html_and_save_to_db(page.body, primary_timetable)
    
    form = page.forms.first
    form["ctl00$cphmain$radiorozvrh"] = "rozvrh na příští týden"
    form["__EVENTTARGET"] = "ctl00$cphmain$radiorozvrh"
    form["__EVENTARGUMENT"] = ""
    form["ctl00$cphmain$Flyrozvrh$checkucitel"] = "on"
    form["ctl00$cphmain$Flyrozvrh$checkskupina"] = "on"
    form["ctl00$cphmain$Flyrozvrh$Checkmistnost"] = "on"
    
    page = form.submit
    
    puts page.body
    
    parse_timetable_from_html_and_save_to_db(page.body, primary_timetable)
  end

  private

  # Parses data from a html (source = string) and saves to the given timetable (target = Timetable)
  def parse_timetable_from_html_and_save_to_db(source, target)
    doc = Nokogiri::XML(source)
    
    timetable = doc.at_css("div#trozvrh")
    
    days = timetable.css("tr")
    # remove first element (časy a trvání hodin)
    days.shift
    
    days.each do |day|
      #day_title = day.at_css("td.r_rozden div.r_bunkaden div.r_den").content
      date = Date.parse(day.at_css("td.r_rozden div.r_bunkaden div.r_datum").content + Time.now.year.to_s)
      
      duplicates = SchoolDay.where(date: date)
      duplicates.each do |duplicate|
        duplicate.destroy
      end

      lessons = day.css("td.r_rrw div.r_bunka, td.r_rrzm")

      school_day = SchoolDay.create(weekday: days.index(day), date: date, timetable: target)
      
      lessons.each do |lesson|
        subject_string = lesson.at_css("div.r_predm").content
        room = lesson.at_css("div.r_mist").content
        teacher_string = lesson.at_css("div.r_ucit")["title"]
        
        subject = Subject.find_by_name(subject_string)
        if(!subject)
          subject = Subject.create(name: subject_string)
        end
        
        teacher = Teacher.find_by_name(teacher_string)
        if(!teacher)
          group_string = lesson.at_css("div.r_skup")
          if(!group_string)
            group_string = 0
          else
            group_string = group_string.content
          end
          teacher = Teacher.create(name: teacher_string, group: group_string.to_s.to_i)
        end
        
        school_day.lessons.create(subject: subject, room: room, teacher: teacher)
      end
    end
  end
  
  def drop_todays_after(items, hour)
    if Time.now >= (Date.today + hour.hours)
      items.drop_while { |e| e.date == Date.today  }
    else
    items
    end
  end
end
