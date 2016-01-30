class Exam < ActiveRecord::Base
  include GenericUtuItem
  include Hideable
  include Lessonable
  include UtuItemWithDate

  self.inheritance_column = :type

  scope :rakings, -> { where(type: 'RakingExam') }
  scope :written, -> { where(type: 'WrittenExam') }

  def self.types
    %(RakingExam WrittenExam)
  end

  def get_task
    Task.new(title: title, description: description, subject: subject, sgroup_id: sgroup_id, sclass_id: sclass_id, date: date)
  end
end
