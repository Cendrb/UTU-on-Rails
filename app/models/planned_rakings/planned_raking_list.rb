class PlannedRakingList < ActiveRecord::Base
  include GenericUtuItem
  include Hideable

  belongs_to :subject
  belongs_to :sclass
  has_many :planned_raking_entries, dependent: :destroy
  has_many :raking_rounds, dependent: :destroy

  validates_presence_of :beginning, :subject, :rekt_per_hour
  after_commit do
    RakingRound.create!(number: 1, planned_raking_list_id: id, school_year: SchoolYear.current)
  end

  def current_round
    return raking_rounds.last
  end

  def full_name
    return "#{title} (#{subject.name})"
  end
end
