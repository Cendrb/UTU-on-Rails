class SummaryController < ApplicationController
  def summary
    events = []
    Event.all.each do |i|
      if i.end > Time.now
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
    @exams = events
    
    tasks = []
    Task.all.each do |i|
      if i.date > Time.now
        tasks.push(i)        
      end
    end
    @tasks = events
  end
  def details
    events = []
    Event.all.each do |i|
      if i.end > Time.now
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
    @exams = events
    
    tasks = []
    Task.all.each do |i|
      if i.date > Time.now
        tasks.push(i)        
      end
    end
    @tasks = events
  end
end
