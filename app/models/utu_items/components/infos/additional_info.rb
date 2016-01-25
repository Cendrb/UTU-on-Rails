class AdditionalInfo < ActiveRecord::Base
  has_many :info_item_bindings, dependent: :destroy
  belongs_to :subject

  validates_presence_of :name, :url
end