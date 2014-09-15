class DayBitch < ActiveRecord::Base
  validates :date, presence: true
  validates :bitch, presence: true
  belongs_to :bitch
  belongs_to :user
end
