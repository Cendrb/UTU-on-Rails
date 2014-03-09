class Event < ActiveRecord::Base
  validates :title, :description, :start, :end, :location, presence: true
end
