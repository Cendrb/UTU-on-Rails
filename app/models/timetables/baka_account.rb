class BakaAccount < ActiveRecord::Base
  has_many :timetables
  validates :name, :username, :password, presence: {presence: true, message: "nesmí být prázdný"}
end
