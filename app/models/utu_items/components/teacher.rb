class Teacher < ActiveRecord::Base
  validates :name, presence: {presence: true, message: "nesmí být prázdný"}
  has_many :day_teachers
  has_many :lessons
end
