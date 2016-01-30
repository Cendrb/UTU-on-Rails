module GenericUtuItem
  extend ActiveSupport::Concern

  included do
    scope :for_groups, lambda { |groups| where("(sgroup_id = -1) OR (sgroup_id IN (:groups))", { groups: groups.pluck(:id)}) }
    scope :for_class, lambda { |sclass| where("(sclass_id = -1) OR (sclass_id = :sclass)", { sclass: sclass.id }) }
    validates :title, :sgroup_id, :sclass_id, presence: {presence: true, message: "nesmí být prázdný"}

    has_many :info_item_bindings, :as => :item, dependent: :destroy
    has_many :done_utu_items, :as => :item, dependent: :destroy

    scope :id_not_on_list, lambda { |list| where("NOT (ARRAY[id] <@ ARRAY[:ids])", {ids: list}) }
    scope :id_on_list, lambda { |list| where("ARRAY[id] <@ ARRAY[:ids]", {ids: list}) }

    belongs_to :sgroup
    belongs_to :sclass
  end

  def self.find_instance(id, type)
    item = nil
    if type == 'event'
      item = Event.find(id)
    end
    if type == 'task'
      item = Task.find(id)
    end
    if type == 'written_exam'
      item = WrittenExam.find(id)
    end
    if type == 'raking_exam'
      item = RakingExam.find(id)
    end
    if type == 'article'
      item = Article.find(id)
    end
    return item
  end

  def get_utu_type(only_basic = false)
    if self.instance_of?(Event)
      return :event
    end
    if self.instance_of?(Task)
      return :task
    end
    if self.instance_of?(Article)
      return :article
    end
    if only_basic
      if self.instance_of?(WrittenExam) || self.instance_of?(RakingExam)
        return :exam
      end
    else
      if self.instance_of?(WrittenExam)
        return :written_exam
      end
      if self.instance_of?(RakingExam)
        return :raking_exam
      end
    end
    return :fuck_off
  end
end