class Exam < ActiveRecord::Base
  include GenericUtuItem
  include Hideable
  include Lessonable

  belongs_to :subject

  self.inheritance_column = :type

  scope :rakings, -> { where(type: 'RakingExam') }
  scope :written, -> { where(type: 'WrittenExam') }

  scope :in_future, -> { where('date >= :today AND passed = false', {today: Date.today}) }
  scope :between_dates, lambda { |from, to| where("date >= :from AND date <= :to ", {from: from, to: to}) }
  scope :id_not_on_list, lambda { |list| where(" NOT (ARRAY[id] < @ ARRAY[:ids]) ", {ids: list}) }
  scope :id_on_list, lambda { |list| where(" ARRAY[id] < @ ARRAY[:ids] ", {ids: list}) }

  validates :date, :subject_id, presence: {presence: true, message: " nesmí být prázdný "}

  belongs_to :sclass
  belongs_to :sgroup


  def self.types
    %(RakingExam WrittenExam)
  end

  def get_task
    Task.new(title: title, description: description, subject: subject, sgroup_id: sgroup_id, sclass_id: sclass_id, date: date)
  end
end