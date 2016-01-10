class InfoItemBinding < ActiveRecord::Base
  belongs_to :additional_info
  belongs_to :utu_item, polymorphic: true
end
