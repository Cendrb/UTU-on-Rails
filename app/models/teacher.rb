class Teacher < ActiveRecord::Base
  validates :name, presence: {presence: true, message: "nesmí být prázdný"}
  validates :group, presence: {presence: true, message: "nesmí být prázdný"}
  has_many :day_teachers
  scope :for_group, lambda { |group| where("\"group\" = :group OR \"group\" = 0", { group: group }) }
end
