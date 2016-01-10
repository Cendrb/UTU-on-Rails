class InfoItemBinding < ActiveRecord::Base
  belongs_to :additional_info
  belongs_to :item, polymorphic: true
end
