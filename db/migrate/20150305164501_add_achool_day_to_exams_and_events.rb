class AddAchoolDayToExamsAndEvents < ActiveRecord::Migration
  def change
    add_column :exams, :school_day_id, :integer
    add_column :tasks, :school_day_id, :integer
  end
end
