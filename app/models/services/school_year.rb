class SchoolYear < ActiveRecord::Base
  has_many :holidays
  has_many :services

  def readable_name
    return "#{beginning_year}/#{beginning_year + 1}"
  end
end
