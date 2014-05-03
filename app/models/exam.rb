class Exam < ActiveRecord::Base
  SUBJECTS = ["MA", "F", "ČJL", "HV", "VV", "IKT", "D", "VO", "NJ", "AJ", "TV", "PŘÍ", "CH", "Z"]
  scope :in_future, where('date >= :today', { today: Date.today })
  scope :for_group, lambda { |group| where("\"group\" = :group OR \"group\" = 0", { group: group }) }
  scope :between_dates, lambda { |from, to| where("date >= :from AND date <= :to", { from: from, to: to } ) }
  validates :title, :description, :subject, :group, :date, presence: {presence: true, message: "nesmí být prázdný"}
  validates :subject, inclusion: {in: SUBJECTS, message: "není platný předmět"}
  validates :group, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 2, only_integer: true, message: "neexistuje - zadejte 0 pro obě skupiny" }
end
