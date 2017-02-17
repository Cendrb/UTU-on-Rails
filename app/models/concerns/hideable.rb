module Hideable
  extend ActiveSupport::Concern

  included do
    has_many :done_utu_items, :as => :item, dependent: :destroy
  end

  def is_done?
    DoneUtuItem.where('user_id = :user AND item_id = :item AND item_type = :type', { user: User.current, item: self, type: self.get_utu_type }).exists?
  end

  def mark_as_undone
    DoneUtuItem.where('user_id = :user AND item_id = :item AND item_type = :type', { user: User.current, item: self, type: self.get_utu_type }).destroy_all
  end

  def mark_as_done
    if !is_done?
      item = DoneUtuItem.new(user: User.current, item_id: self.id, item_type: self.get_utu_type)
      return item.save
    end
    return true
  end
end