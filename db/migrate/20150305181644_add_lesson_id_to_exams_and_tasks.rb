class AddLessonIdToExamsAndTasks < ActiveRecord::Migration
  def change
    add_column :exams, :lesson_id, :integer
    add_column :tasks, :lesson_id, :integer
  end
end
