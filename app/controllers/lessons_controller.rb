class LessonsController < ApplicationController
  def dialog_for_timetable
    @items = Exam.where(id: params[:exams]) + Task.where(id: params[:tasks])
  end
end
