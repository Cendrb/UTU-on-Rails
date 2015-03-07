class RemoveWeekDayFromSchoolDays < ActiveRecord::Migration
  def change
    remove_column :school_days, :weekday
  end
end
