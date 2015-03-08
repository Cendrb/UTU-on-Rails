class RemoveInPastToExamsAndTasks < ActiveRecord::Migration
  def change
    remove_column :exams, :in_past
    remove_column :tasks, :in_past
  end
end
