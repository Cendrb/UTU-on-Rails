class SummaryController < ApplicationController
  def summary
    events = []
    Event.all.each do |i|
      if i.event_end > Time.now
        events.push(i)        
      end
    end
    @events = events
    
    exams = []
    Exam.all.each do |i|
      if i.date > Time.now
        exams.push(i)        
      end
    end
    @exams = exams
    
    tasks = []
    Task.all.each do |i|
      if i.date > Time.now
        tasks.push(i)        
      end
    end
    @tasks = tasks
    
    services = []
    Service.all.each do |i|
      if i.service_end > Time.now
        services.push(i)
      end
    end
    
    @services = services
  end
  def details
    events = (Event.all.order(:start)).where("event_end > ?", Date.today)
    @events = events 
    
    exams = []
    Exam.all.each do |i|
      if i.date > Time.now
        exams.push(i)        
      end
    end
    @exams = exams
    
    tasks = []
    Task.all.each do |i|
      if i.date > Time.now
        tasks.push(i)        
      end
    end
    @tasks = tasks
  end
end
