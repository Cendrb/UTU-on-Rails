class LessonsUseTeachersIds < ActiveRecord::Migration
  def change
    remove_column :lessons, :teacher
    add_column :lessons, :teacher_id, :integer
  end
end
