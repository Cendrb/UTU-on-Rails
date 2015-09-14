class PlannedRakingList < ActiveRecord::Base
  belongs_to :subject
  has_many :planned_raking_entries
end
