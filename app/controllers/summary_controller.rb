class SummaryController < ApplicationController
  def summary
    events = []
    Event.all.each do |i|
      if i.end > Time.now
        events.push(i)        
      end
    end
    @events = events
    @tasks = Task.all
    @exam = Exam.all
  end
  def details
    @events = Event.all
    @tasks = Task.all
    @exam = Exam.all
  end
end
