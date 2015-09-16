class PlannedRakingList < ActiveRecord::Base
  belongs_to :subject
  has_many :planned_raking_entries

  validates_presence_of :beginning, :subject_id, :title, :rekt_per_hour
end
