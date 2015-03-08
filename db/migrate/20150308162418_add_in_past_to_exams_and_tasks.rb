class AddInPastToExamsAndTasks < ActiveRecord::Migration
  def change
    add_column :exams, :in_past, :boolean
    add_column :tasks, :in_past, :boolean
  end
end
