class Holiday < ActiveRecord::Base
  belongs_to :school_year

  validates_presence_of :holiday_beginning, :holiday_end
end
