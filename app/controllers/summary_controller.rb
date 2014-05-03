class SummaryController < ApplicationController
  
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

  def details
    if params[:range] && params[:group]
      from = Date.new(params[:range][:"from(1i)"].to_i,params[:range][:"from(2i)"].to_i,params[:range][:"from(3i)"].to_i)
      to = Date.new(params[:range][:"to(1i)"].to_i,params[:range][:"to(2i)"].to_i,params[:range][:"to(3i)"].to_i)
      @events = Event.order(:event_start).between_dates(from, to)
      @exams = Exam.order(:date).for_group(params[:group]).between_dates(from, to)
      @tasks = Task.order(:date).for_group(params[:group]).between_dates(from, to)
    else
      @events = (Event.all.order(:event_start)).in_future
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
      format.atom
    end
  end

  def service_list
    @services = Service.order(:service_start).in_future
  end

  def administration

  end

  private
    def get_tasks_with_group(group)
      tasks = Task.order(:date).in_future.for_group(group)
      if Time.now >= (Date.today + 12.hours)
        tasks = tasks.drop_while { |e| e.date == Date.today  }
      end
      return tasks
    end
  
    def get_exams_with_group(group)
      exams = Exam.order(:date).in_future.for_group(group)
      if Time.now >= (Date.today + 12.hours)
        exams = exams.drop_while { |e| e.date == Date.today  }
      end
      return exams
    end
  
    def get_tasks
      tasks = Task.order(:date).in_future
      if Time.now >= (Date.today + 12.hours)
        tasks = tasks.drop_while { |e| e.date == Date.today  }
      end
      return tasks
    end
  
    def get_exams
      exams = Exam.order(:date).in_future
      if Time.now >= (Date.today + 12.hours)
        exams = exams.drop_while { |e| e.date == Date.today  }
      end
      return exams
    end
end
