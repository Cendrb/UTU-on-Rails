class PlannedRakingEntry < ActiveRecord::Base
  belongs_to :planned_raking_list
  belongs_to :raking_round
  belongs_to :class_member

  validates_presence_of :sorting_order, :class_member, :planned_raking_list, :raking_round
end
