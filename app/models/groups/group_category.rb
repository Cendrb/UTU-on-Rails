class GroupCategory < ActiveRecord::Base
  validates_presence_of :name
  has_many :sgroups, dependent: :destroy
end
