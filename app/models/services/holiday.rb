class HolidayDateValidator < ActiveModel::Validator
  def validate(record)
    if record.holiday_end < record.holiday_beginning
      record.errors.add(:holiday_end, 'musí být později než začátek prázdnin')
    end
  end
end

class Holiday < ActiveRecord::Base
  belongs_to :school_year

  validates_with HolidayDateValidator

  validates_presence_of :holiday_beginning, :holiday_end, :school_year
end
