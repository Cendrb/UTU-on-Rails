class SchoolYear < ActiveRecord::Base
  has_many :holidays
  has_many :services

  def readable_name
    return "#{beginning_year}/#{beginning_year + 1}"
  end

  def generate_services_from(date)
    if date >= Date.new(beginning_year, 9, 1) && date <= Date.new(beginning_year + 1, 6, 30)
      # date is in current school year

    end
  end
end
