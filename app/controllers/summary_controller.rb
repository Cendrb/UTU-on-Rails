class SummaryController < ApplicationController
  def summary
    if logged_in?
      user_names = current_user.name.split(' ')
      services = Service.where("service_end >= :today", { :today => Date.today })
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
    @near_payments = (Event.all.order(:event_start)).where("event_end >= :today AND pay_date <= :pay AND pay_date != event_start", { :today => Date.today, :pay => Date.today + 7.days } )
  end

  def details
    if params[:range] && params[:group]
      from = Date.new(params[:range][:"from(1i)"].to_i,params[:range][:"from(2i)"].to_i,params[:range][:"from(3i)"].to_i)
      to = Date.new(params[:range][:"to(1i)"].to_i,params[:range][:"to(2i)"].to_i,params[:range][:"to(3i)"].to_i)
      @events = Event.order(:event_start).where("event_start >= :from AND event_end <= :to", { :from => from, :to => to } )
      @exams = Exam.order(:date).where("\"group\" = :group OR \"group\" = 0", { :group => params[:group] } ).where("date >= :from AND date <= :to", { :from => from, :to => to } )
      @tasks = Task.order(:date).where("\"group\" = :group OR \"group\" = 0", { :group => params[:group] } ).where("date >= :from AND date <= :to", { :from => from, :to => to } )
    else
      @events = (Event.all.order(:event_start)).where("event_end >= ?", Date.today)
      if logged_in?
        @exams = get_exams_with_group(current_user.group)
        @tasks = get_tasks_with_group(current_user.group)
      else
        @exams = get_exams
        @tasks = get_tasks
      end
    end

    respond_to do |format|
      format.html
      format.xml
    end
  end

  def service_list
    @services = (Service.all.order(:service_start)).where("service_end >= :today", { :today => Date.today } )
  end

  def administration

  end

  private

  def get_tasks_with_group(group)
    tasks = Task.order(:date).where("date >= :today", { :today => Date.today } ).where("\"group\" = :group OR \"group\" = 0", { :group => group } )
    if Time.now >= (Date.today + 12.hours)
      tasks = tasks.drop_while { |e| e.date == Date.today  }
    end
    return tasks
  end

  def get_exams_with_group(group)
    exams = Exam.order(:date).where("date >= :today", { :today => Date.today } ).where("\"group\" = :group OR \"group\" = 0", { :group => group } )
    if Time.now >= (Date.today + 12.hours)
      exams = exams.drop_while { |e| e.date == Date.today  }
    end
    return exams
  end

  def get_tasks
    tasks = Task.order(:date).where("date >= :today", { :today => Date.today } )
    if Time.now >= (Date.today + 12.hours)
      tasks = tasks.drop_while { |e| e.date == Date.today  }
    end
    return tasks
  end

  def get_exams
    exams = Exam.order(:date).where("date >= :today", { :today => Date.today } )
    if Time.now >= (Date.today + 12.hours)
      exams = exams.drop_while { |e| e.date == Date.today  }
    end
    return exams
  end
end
