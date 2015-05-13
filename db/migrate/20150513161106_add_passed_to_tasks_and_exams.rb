class AddPassedToTasksAndExams < ActiveRecord::Migration
  def change
    add_column :tasks, :passed, :boolean
    add_column :exams, :passed, :boolean
  end
end
