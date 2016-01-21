class SchoolYear < ActiveRecord::Base
  has_many :holidays
  has_many :raking_rounds
  has_many :services

  validates_presence_of :beginning_year
  validates_uniqueness_of :beginning_year

  def readable_name
    return "#{beginning_year}/#{beginning_year + 1}"
  end

  def self.current
    if Date.today.month >= 9 && Date.today.month <= 12
      return SchoolYear.find_by_beginning_year(Date.today.year)
    end
    if Date.today.month >= 1 && Date.today.month <= 6
      return SchoolYear.find_by_beginning_year(Date.today.year - 1)
    end
  end
end
