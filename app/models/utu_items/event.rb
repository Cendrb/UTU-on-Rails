class EventDateValidator < ActiveModel::Validator
  def validate(record)
    if record.event_end < record.event_start
      record.errors.add(:event_end, 'musí být později než začátek akce')
    end
  end
end

class Event < ActiveRecord::Base
  include GenericUtuItem
  include Hideable

  scope :in_future, -> { where('event_end >= :today', { today: Date.today }) }
  scope :between_dates, lambda { |from, to| where("event_start >= :from AND event_end <= :to", { from: from, to: to } ) }
  scope :id_not_on_list, lambda { |list| where("NOT (ARRAY[id] <@ ARRAY[:ids])", { ids: list } ) }
  scope :id_on_list, lambda { |list| where("ARRAY[id] <@ ARRAY[:ids]", { ids: list } ) }
  
  validates :event_start, :event_end, :location, presence: {presence: true, message: "nesmí být prázdný"}
  validates :price, numericality: true
  validates_with EventDateValidator

  belongs_to :sclass
  belongs_to :sgroup
end