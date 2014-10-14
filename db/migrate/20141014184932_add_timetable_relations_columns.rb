class AddTimetableRelationsColumns < ActiveRecord::Migration
  def change
    add_column :lessons, :school_day_id, :integer
    add_column :school_days, :timetable_id, :integer
  end
end
