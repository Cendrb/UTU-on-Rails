module GenericUtuItem
  extend ActiveSupport::Concern

  included do
    scope :for_groups, lambda { |groups| where("(sgroup_id = -1) OR (sgroup_id IN (:groups))", { groups: groups.pluck(:id)}) }
    scope :for_class, lambda { |sclass| where("(sclass_id = -1) OR (sclass_id = :sclass)", { sclass: sclass.id }) }
    validates :title, :sgroup_id, :sclass_id, presence: {presence: true, message: "nesmí být prázdný"}
  end

  def get_utu_type
    if self.instance_of?(Event)
      return :event
    end
    if self.instance_of?(Task)
      return :task
    end
    if self.instance_of?(WrittenExam)
      return :written_exam
    end
    if self.instance_of?(RakingExam)
      return :raking_exam
    end
    return :fuck_off
  end
end