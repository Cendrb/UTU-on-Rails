class RemoveOldDogshitFromPlannedRakingEntries < ActiveRecord::Migration
  def change
    remove_column :planned_raking_entries, :name
  end
end
