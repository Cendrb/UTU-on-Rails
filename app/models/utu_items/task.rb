class Task < ActiveRecord::Base
  include GenericUtuItem
  include Hideable
  include Lessonable
  include UtuItemWithDate

  def get_exam(type)
    Exam.new(title: title, description: description, subject: subject, sgroup_id: sgroup_id, sclass_id: sclass_id, date: date, type: type)
  end
end
