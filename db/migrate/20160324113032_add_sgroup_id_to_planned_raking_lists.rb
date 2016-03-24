class AddSgroupIdToPlannedRakingLists < ActiveRecord::Migration
  def change
    add_column :planned_raking_lists, :sgroup_id, :integer
  end
end
