class RenameBToTeacher < ActiveRecord::Migration
  def change
    rename_table :bitches, :teachers
    rename_table :day_bitches, :day_teachers
  end
end
