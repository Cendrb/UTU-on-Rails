class PlannedRakingList < ActiveRecord::Base
  belongs_to :subject
  belongs_to :sclass
  has_many :planned_raking_entries, dependent: :destroy
  has_many :raking_rounds, dependent: :destroy

  validates_presence_of :beginning, :subject, :title, :rekt_per_hour, :sclass
  after_create do
    RakingRound.create(number: 1, planned_raking_list_id: id)
  end

  def current_round
    return raking_rounds.order(:number).last
  end
end
