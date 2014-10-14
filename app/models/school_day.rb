class SchoolDay < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  belongs_to :timetable
end
