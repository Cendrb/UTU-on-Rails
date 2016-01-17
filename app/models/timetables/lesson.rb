class Lesson < ActiveRecord::Base
  belongs_to :school_day
  belongs_to :teacher
  belongs_to :subject
  has_many :lesson_item_bindings, dependent: :destroy
  has_many :exams, through: :lesson_item_bindings, source: :item, source_type: "Exam"
  has_many :tasks, through: :lesson_item_bindings, source: :item, source_type: "Task"
  
  def exams_or_tasks?
    return self.exams.count > 0 || self.tasks.count > 0
  end
  
  def get_titles_string
    return (self.exams.pluck(:title) + self.tasks.pluck(:title)).join("\n")
  end
end
