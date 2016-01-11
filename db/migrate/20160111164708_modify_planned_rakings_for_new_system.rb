class ModifyPlannedRakingsForNewSystem < ActiveRecord::Migration
  def change
    remove_column :planned_raking_entries, :user_id
    add_column :planned_raking_entries, :class_member_id, :integer
  end
end
