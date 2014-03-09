class Exam < ActiveRecord::Base
  SUBJECTS = ["MA", "F", "ČJL", "HV", "VV", "IKT", "D", "VO", "NJ", "AJ", "TV", "PŘÍ"]
  validates :title, :description, :subject, :group, :date, presence: {presence: true, message: "nesmí být prázdný"}
  validates :subject, inclusion: {in: SUBJECTS, message: "není platný předmět"}
  validates :group, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 2, only_integer: true, message: "neexistuje" }
end
