class ChangeGradeTypeToStringInPlannedRakingEntries < ActiveRecord::Migration
  def change
    remove_column :planned_raking_entries, :grade
    add_column :planned_raking_entries, :grade, :string
  end
end
