class Lesson < ActiveRecord::Base
  belongs_to :school_day
  belongs_to :teacher
  belongs_to :subject
end