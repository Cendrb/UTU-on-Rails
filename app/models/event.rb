class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.event_end < record.event_start
      record.errors.add(:event_end, 'musí být později než začátek akce')
    end
  end
end

class Event < ActiveRecord::Base
  validates :title, :description, :event_start, :event_end, :location, presence: {presence: true, message: "nesmí být prázdný"}
  validates_with DateValidator
end
