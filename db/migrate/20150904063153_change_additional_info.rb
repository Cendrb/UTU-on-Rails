class ChangeAdditionalInfo < ActiveRecord::Migration
  def change
    remove_column :additional_infos, :event_id
    remove_column :additional_infos, :raking_id
    remove_column :additional_infos, :exam_id
    rename_column :additional_infos, :task_id, :info_item_binding_id
  end
end
