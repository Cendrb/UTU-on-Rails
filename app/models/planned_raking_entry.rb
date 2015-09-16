class PlannedRakingEntry < ActiveRecord::Base
  belongs_to :planned_raking_list
  belongs_to :user

  validates_presence_of :sorting_order, :name, :planned_raking_list_id
end
