class Bitch < ActiveRecord::Base
  validates :name, presence: {presence: true, message: "nesmí být prázdný"}
  validates :group, presence: {presence: true, message: "nesmí být prázdný"}
  has_many :botds
end
