class Task < ActiveRecord::Base
  include GenericUtuItem
  include Hideable
  include Lessonable

  belongs_to :subject

  scope :in_future, -> { where('date >= :today AND passed != true', {today: Date.today}) }
  scope :for_group, lambda { |group| where("\"group\" = :group OR \"group\" = 0", {group: group}) }
  scope :between_dates, lambda { |from, to| where("date >= :from AND date <= :to", {from: from, to: to}) }
  scope :id_not_on_list, lambda { |list| where("NOT (ARRAY[id] <@ ARRAY[:ids])", {ids: list}) }
  scope :id_on_list, lambda { |list| where("ARRAY[id] <@ ARRAY[:ids]", {ids: list}) }

  validates :date, :subject_id, presence: {presence: true, message: "nesmí být prázdný"}

  belongs_to :sclass
  belongs_to :sgroup

  def get_exam(type)
    Exam.new(title: title, description: description, subject: subject, sgroup_id: sgroup_id, sclass_id: sclass_id, date: date, type: type)
  end
end