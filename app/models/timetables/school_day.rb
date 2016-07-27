class SchoolDay < ActiveRecord::Base
  has_many :lessons,  -> { order(serial_number: :asc) }, dependent: :destroy
  belongs_to :timetable

  scope :current_week_days, -> { where('school_days.date': Date.today.beginning_of_week..Date.today.end_of_week) }
  scope :next_week_days, -> { where('school_days.date': (Date.today + 1.week).beginning_of_week..(Date.today + 1.week).end_of_week) }
  scope :next_two_weeks_days, -> { where('school_days.date': Date.today.beginning_of_week..(Date.today + 1.week).end_of_week) }

  validates_presence_of :timetable
end
