module Lessonable
  extend ActiveSupport::Concern

  included do
    before_create :init
  end

  def init
    self.passed = false
    true
  end

  def find_and_set_lesson
    #Lesson.joins(:school_day => :timetable).where("school_days.date >= ?", self.date).where(subject: self.subject).where("timetables.group = ?", self.group).order("school_days.date ASC").first
  end
end