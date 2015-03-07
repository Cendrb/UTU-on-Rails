class AddGroupIntegerToTimetables < ActiveRecord::Migration
  def change
    add_column :timetables, :group, :integer
  end
end
