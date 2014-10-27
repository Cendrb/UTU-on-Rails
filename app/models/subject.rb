class Subject < ActiveRecord::Base
  has_many :lessons
  has_many :exams
  has_many :tasks
end
