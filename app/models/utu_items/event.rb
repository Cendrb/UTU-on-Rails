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
  
  validates :event_start, :event_end, :location, presence: {presence: true, message: "nesmí být prázdný"}
  validates :price, numericality: true
  validates_with EventDateValidator
end
