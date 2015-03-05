class RemoveSchoolDayFromExamsAndEvents < ActiveRecord::Migration
  def change
    remove_column :exams, :school_day_id
    remove_column :tasks, :school_day_id
  end
end
