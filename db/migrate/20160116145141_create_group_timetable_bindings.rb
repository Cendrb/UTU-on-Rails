class CreateGroupTimetableBindings < ActiveRecord::Migration
  def change
    create_table :group_timetable_bindings do |t|
      t.integer :sgroup_id
      t.integer :timetable_id

      t.timestamps
    end
  end
end
