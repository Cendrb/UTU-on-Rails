class RakingRound < ActiveRecord::Base
  belongs_to :planned_raking_list
  belongs_to :school_year
  has_many :planned_raking_entries, dependent: :destroy

  validates_presence_of :planned_raking_list, :school_year, :number
end
