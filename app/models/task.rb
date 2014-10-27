class Task < ActiveRecord::Base
  belongs_to :subject

  scope :in_future, -> { where('date >= :today', { today: Date.today }) }
  scope :for_group, lambda { |group| where("\"group\" = :group OR \"group\" = 0", { group: group }) }
  scope :between_dates, lambda { |from, to| where("date >= :from AND date <= :to", { from: from, to: to } ) }
  scope :id_not_on_list, lambda { |list| where("NOT (ARRAY[id] <@ ARRAY[:ids])", { ids: list } ) }
  scope :id_on_list, lambda { |list| where("ARRAY[id] <@ ARRAY[:ids]", { ids: list } ) }
  
  validates :title, :subject_id, :group, :date, presence: {presence: true, message: "nesmí být prázdný"}
  validates :group, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 2, only_integer: true, message: "neexistuje - zadejte 0 pro obě skupiny" }
  
  def get_exam
    Exam.new(title: title, description: description, subject: subject, group: group, date: date)
  end
end
