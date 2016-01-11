class PlannedRakingEntry < ActiveRecord::Base
  belongs_to :planned_raking_list
  belongs_to :class_member

  validates_presence_of :sorting_order, :class_member_id, :planned_raking_list_id
end
