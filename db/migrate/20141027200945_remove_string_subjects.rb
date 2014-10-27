class RemoveStringSubjects < ActiveRecord::Migration
  def change
    remove_column :tasks, :subject
    remove_column :exams, :subject
  end
end
