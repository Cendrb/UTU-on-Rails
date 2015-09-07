class ServiceDateValidator < ActiveModel::Validator
  def validate(record)
    if record.service_end < record.service_start
      record.errors.add(:service_end, 'musí být později než začátek akce')
    end
  end
end

class Service < ActiveRecord::Base
  validates :first_name, :second_name, :service_start, :service_end, presence: { presence: true, message: "nesmí být prázdný" }
  scope :in_future, -> { where('service_end >= :today', { today: Date.today }) }
  validates_with ServiceDateValidator

  def self.add_one_year
    datediff = 1.year - 1.day
    Service.find_each do |service|
      service.service_start += datediff
      service.service_end += datediff
      service.save!
    end
  end
end
