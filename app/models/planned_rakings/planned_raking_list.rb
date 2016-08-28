class PlannedRakingList < ActiveRecord::Base
  include GenericUtuItem
  include Hideable

  belongs_to :subject
  belongs_to :sclass
  has_many :planned_raking_entries, dependent: :destroy
  has_many :raking_rounds, dependent: :destroy

  validates_presence_of :beginning, :subject, :rekt_per_hour
  after_commit do
    if raking_rounds.count == 0
      RakingRound.create!(number: 1, planned_raking_list_id: id, school_year: SchoolYear.current)
    end
  end

  def current_round
    if raking_rounds.count == 0
      return RakingRound.create!(number: 1, planned_raking_list_id: id, school_year: SchoolYear.current)
    else
      return raking_rounds.last
    end
  end

  def full_name
    return "#{title} (#{subject.name})"
  end
end
