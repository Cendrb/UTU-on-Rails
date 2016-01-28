class AdditionalInfo < ActiveRecord::Base
  has_many :info_item_bindings, dependent: :destroy
  belongs_to :subject
  belongs_to :sclass

  scope :for_class, lambda { |sclass_id| where(sclass_id: sclass_id).order('subject_id ASC, created_at DESC') }
  scope :for_subject, lambda { |subject_id| where(subject_id: subject_id) }

  validates_presence_of :name, :url, :sclass_id
end