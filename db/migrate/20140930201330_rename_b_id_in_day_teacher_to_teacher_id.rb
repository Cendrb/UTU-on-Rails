class RenameBIdInDayTeacherToTeacherId < ActiveRecord::Migration
  def change
    rename_column :day_teachers, :bitch_id, :teacher_id
  end
end
