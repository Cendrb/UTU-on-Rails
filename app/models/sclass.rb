class Sclass < ActiveRecord::Base
  validates_presence_of :name
  has_many :class_members
  has_many :services
  has_many :events
  has_many :exams
  has_many :tasks
  has_many :planned_raking_lists
end
