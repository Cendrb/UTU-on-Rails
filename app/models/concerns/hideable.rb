module Hideable
  extend ActiveSupport::Concern

  def is_done?
    DoneUtuItem.where('user_id = :user AND item_id = :item AND item_type = :type', { user: User.current, item: self, type: self.get_utu_type }).exists?
  end

  def mark_as_undone
    DoneUtuItem.where('user_id = :user AND item_id = :item AND item_type = :type', { user: User.current, item: self, type: self.get_utu_type }).destroy_all
  end

  def mark_as_done
    if !is_done?
      DoneUtuItem.create(user: User.current, item_id: self.id, item_type: self.get_utu_type)
    end
  end
end