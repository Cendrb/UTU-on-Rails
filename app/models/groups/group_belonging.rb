class GroupBelonging < ActiveRecord::Base
  validates_presence_of :class_member_id, :sgroup_id
  belongs_to :class_member
  belongs_to :sgroup
end
