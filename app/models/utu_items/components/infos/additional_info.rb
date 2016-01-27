class AdditionalInfo < ActiveRecord::Base
  has_many :info_item_bindings, dependent: :destroy
  belongs_to :subject
  belongs_to :sclass

  validates_presence_of :name, :url, :class_id
end