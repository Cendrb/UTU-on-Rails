class SummaryController < ApplicationController
  def index
    @events = Event.all
    @tasks = Task.all
    @exam = Exam.all
  end
end
