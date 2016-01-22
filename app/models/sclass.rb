class Sclass < ActiveRecord::Base
  validates_presence_of :name, :default_timetable_id
  has_many :class_members
  has_many :services
  has_many :events
  has_many :exams
  has_many :tasks
  has_many :planned_raking_lists
  has_many :timetables
  has_many :articles

  def default_timetable
    return Timetable.find(default_timetable_id)
  end
end
