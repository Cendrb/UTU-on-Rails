class Timetable < ActiveRecord::Base
  has_many :school_days, dependent: :destroy
end
