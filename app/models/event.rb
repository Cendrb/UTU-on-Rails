class Event < ActiveRecord::Base
  validates :title, :description, :start, :end, :location, presence: {presence: true, message: "nesmí být prázdný"}
end
