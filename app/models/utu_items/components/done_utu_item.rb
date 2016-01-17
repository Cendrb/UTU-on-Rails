class DoneUtuItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, polymorphic: true

  validates_presence_of :user, :item_id, :item_type
end