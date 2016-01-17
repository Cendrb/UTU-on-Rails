class GroupBelonging < ActiveRecord::Base
  validates_presence_of :class_member, :sgroup
  belongs_to :class_member
  belongs_to :sgroup
end
