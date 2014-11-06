class AddBakaAccountToTimetable < ActiveRecord::Migration
  def change
    add_column :timetables, :baka_account_id, :integer
  end
end
