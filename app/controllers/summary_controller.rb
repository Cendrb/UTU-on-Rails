class SummaryController < ApplicationController
  def summary
    @events = (Event.all.order(:event_start)).where("event_end >= :today", { :today => Date.today })
    
    @exams = (Exam.all.order(:date)).where("date >= :today", { :today => Date.today } )
    
    @tasks = (Task.all.order(:date)).where("date >= :today", { :today => Date.today } )
    
    @services = (Service.all.order(:service_start)).where("service_end >= :today", { :today => Date.today } )
  end
  def details
    @events = (Event.all.order(:event_start)).where("event_end >= ?", Date.today)
    
    if current_user
      @exams = (Exam.all.order(:date)).where("date >= :today", { :today => Date.today } ).where("\"group\" = :group OR \"group\" = 0", { :group => current_user.group } )
      if Time.now >= (Date.today + 12.hours)
        @exams = @exams.drop_while { |e| e.date == Date.today  }
      end
      
      @tasks = (Task.all.order(:date)).where("date >= :today", { :today => Date.today } ).where("\"group\" = :group OR \"group\" = 0", { :group => current_user.group } )
      if Time.now >= (Date.today + 12.hours)
        @tasks = @tasks.drop_while { |e| e.date == Date.today  }
      end
    else
      @exams = (Exam.all.order(:date)).where("date >= :today", { :today => Date.today } )
      if Time.now >= (Date.today + 12.hours)
        @exams = @exams.drop_while { |e| e.date == Date.today  }
      end
      
      @tasks = (Task.all.order(:date)).where("date >= :today", { :today => Date.today } )
      if Time.now >= (Date.today + 12.hours)
        @tasks = @tasks.drop_while { |e| e.date == Date.today  }
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
end
