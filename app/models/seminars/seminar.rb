class Seminar < ActiveRecord::Base
  belongs_to :subject
  has_many :seminar_lessons

  has_many :seminar_belongings, dependent: :destroy
  has_many :class_members, through: :seminar_belongings
end
