class MoreInformation < ActiveRecord::Base
  validates :url, :name, presence: true
  belongs_to :event
end
