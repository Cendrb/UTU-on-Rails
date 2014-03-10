class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.end < record.start
      record.errors.add(:end, 'musí být později než začátek akce')
    end
  end
end

class Event < ActiveRecord::Base
  validates :title, :description, :start, :end, :location, presence: {presence: true, message: "nesmí být prázdný"}
  validates_with DateValidator
end
