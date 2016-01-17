class BakaAccount < ActiveRecord::Base
  has_one :timetable
  belongs_to :class_member
  validates :class_member, :username, :password, presence: {presence: true, message: "nesmí být prázdný"}
end
