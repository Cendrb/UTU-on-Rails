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
      if logged_in?
        @events = Event.all.order(:event_start).in_future
        @exams = Exam.order(:date).in_future.for_group(current_user.group)
        @tasks = Task.order(:date).in_future.for_group(current_user.group)

        # Umožnění skrytí jednotlivých položek
        if !current_user.show_hidden_events
          @events = @events.id_not_on_list(current_user.hidden_events) if current_user.hidden_events.length > 0
        end
        if !current_user.show_hidden_exams
          @exams = @exams.id_not_on_list(current_user.hidden_exams) if current_user.hidden_exams.length > 0
        end
        if !current_user.show_hidden_tasks
          @tasks = @tasks.id_not_on_list(current_user.hidden_tasks) if current_user.hidden_tasks.length > 0
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

  private

  def drop_todays_after(items, hour)
    if Time.now >= (Date.today + hour.hours)
      items.drop_while { |e| e.date == Date.today  }
    else
    items
    end
  end
end
