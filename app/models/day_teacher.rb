class DayTeacher < ActiveRecord::Base
  validates :date, presence: true
  validates :teacher, presence: true
  belongs_to :teacher
  belongs_to :user
end
