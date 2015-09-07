class RemoveShit < ActiveRecord::Migration
  def change
    remove_column :additional_infos, :info_item_binding_id
  end
end
