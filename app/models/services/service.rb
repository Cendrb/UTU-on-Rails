class ServiceDateValidator < ActiveModel::Validator
  def validate(record)
    if record.service_end < record.service_start
      record.errors.add(:service_end, 'musí být později než začátek služby')
    end
  end
end

class Service < ActiveRecord::Base
  validates :first_mate_id, :second_mate_id, :service_start, :service_end, :sclass_id, :school_year, presence: { presence: true, message: "nesmí být prázdný" }
  scope :in_future, -> { where('service_end >= :today', { today: Date.today }) }
  scope :for_class, lambda { |sclass_id| where(sclass_id: sclass_id) }
  scope :for_school_year, lambda { |school_year_id| where(school_year_id: school_year_id) }
  validates_with ServiceDateValidator

  belongs_to :sclass
  belongs_to :school_year

  def self.add_one_year
    datediff = 1.year - 1.day
    Service.find_each do |service|
      service.service_start += datediff
      service.service_end += datediff
      service.save!
    end
  end

  def self.current
    return Service.where("service_start <= :today AND service_end >= :today", {today: Date.today} ).first
  end

  def first_mate
    ClassMember.find(first_mate_id)
  end

  def second_mate
    ClassMember.find(second_mate_id)
  end

  def self.pyj
    Service.where("service_start > ?", Date.strptime("27.2.2016", "%d.%m.%Y")).each do |zidan|
      zidan.service_start-=1.day
      zidan.service_end-=1.day
      zidan.save!
    end
  end
end
