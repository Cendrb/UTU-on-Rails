class PlannedRakingEntry < ActiveRecord::Base
  belongs_to :planned_raking_list
  belongs_to :user
end
