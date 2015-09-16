class AddDescriptionToPlannedRakingEntries < ActiveRecord::Migration
  def change
    add_column :planned_raking_entries, :description, :text
  end
end
