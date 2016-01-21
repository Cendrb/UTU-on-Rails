class AddPlannedToPlannedRakingLists < ActiveRecord::Migration
  def change
    add_column :planned_raking_lists, :planned, :boolean
  end
end
