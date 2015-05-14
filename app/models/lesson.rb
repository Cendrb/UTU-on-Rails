class Lesson < ActiveRecord::Base
  belongs_to :school_day
  belongs_to :teacher
  belongs_to :subject
  has_many :tasks
  has_many :exams
  
  def exams_or_tasks?
    return self.exams.count > 0 || self.tasks.count > 0
  end
end
