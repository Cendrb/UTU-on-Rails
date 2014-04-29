class MoreInformation < ActiveRecord::Base
  validates_persistence_of :url, :name
  belongs_to :event, :exam, :task
end
