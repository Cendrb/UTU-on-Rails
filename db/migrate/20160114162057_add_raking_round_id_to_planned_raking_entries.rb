class AddRakingRoundIdToPlannedRakingEntries < ActiveRecord::Migration
  def change
    add_column :planned_raking_entries, :raking_round_id, :integer
  end
end
