class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.service_end < record.service_start
      record.errors.add(:service_end, 'musí být později než začátek akce')
    end
  end
end

class Service < ActiveRecord::Base
  validates :first_name, :second_name, :service_start, :service_end, presence: { presence: true, message: "nesmí být prázdný" }
  validates_with DateValidator
end
