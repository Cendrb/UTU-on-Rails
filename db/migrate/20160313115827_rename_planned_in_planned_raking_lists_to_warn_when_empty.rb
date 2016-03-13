class RenamePlannedInPlannedRakingListsToWarnWhenEmpty < ActiveRecord::Migration
  def change
    remove_column :planned_raking_lists, :planned, :boolean
    add_column :planned_raking_lists, :warn_when_empty, :integer
  end
end
