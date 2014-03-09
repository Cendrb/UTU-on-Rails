class Exam < ActiveRecord::Base
  SUBJECTS = ["MA", "F", "ČJL", "HV", "VV", "IKT", "D", "VO", "NJ", "AJ", "TV", "PŘÍ"]
  validates :title, :description, :subject, :group, :date, presence: true
  validates :subject, :inclusion => SUBJECTS
end
