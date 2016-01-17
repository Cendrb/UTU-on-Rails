class InfoItemBinding < ActiveRecord::Base
  belongs_to :additional_info
  belongs_to :item, polymorphic: true

  validates_presence_of :item_id, :item_type, :additional_info
end
