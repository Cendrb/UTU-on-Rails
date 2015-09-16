class AddRektPerHourToPlannedRakingLists < ActiveRecord::Migration
  def change
    add_column :planned_raking_lists, :rekt_per_hour, :integer
  end
end
