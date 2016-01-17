class ChangeFinishedToGradeInRakingEntries < ActiveRecord::Migration
  def change
    add_column :planned_raking_entries, :grade, :integer
  end
end
