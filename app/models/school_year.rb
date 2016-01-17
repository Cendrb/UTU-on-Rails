class SchoolYear < ActiveRecord::Base
  has_many :holidays
  has_many :raking_rounds
  has_many :services

  validates_presence_of :beginning_year
  validates_uniqueness_of :beginning_year

  def readable_name
    return "#{beginning_year}/#{beginning_year + 1}"
  end
end
