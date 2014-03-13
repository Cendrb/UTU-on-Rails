class SummaryController < ApplicationController
  def summary
    @events = (Event.all.order(:event_start)).where("event_end >= :today", { :today => Date.today })
    
    @exams = (Exam.all.order(:date)).where("date >= :today", { :today => Date.today } )
    
    @tasks = (Task.all.order(:date)).where("date >= :today", { :today => Date.today } )
    
    @services = (Service.all.order(:service_start)).where("service_start >= :today", { :today => Date.today } )
  end
  def details
    @events = (Event.all.order(:event_start)).where("event_end >= ?", Date.today) # Je možné oběma způsoby
    
    @exams = (Exam.all.order(:date)).where("date >= :today", { :today => Date.today } ) # Je možné oběma způsoby
    
    @tasks = (Task.all.order(:date)).where("date >= :today", { :today => Date.today } )
  end
end
