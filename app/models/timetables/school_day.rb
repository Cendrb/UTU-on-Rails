class SchoolDay < ActiveRecord::Base
  has_many :lessons,  -> { order(serial_number: :asc) }, dependent: :destroy
  belongs_to :timetable

  validates_presence_of :timetable
end
