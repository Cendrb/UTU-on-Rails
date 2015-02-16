class RemoveHiddenColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :hidden_events
    remove_column :users, :hidden_exams
    remove_column :users, :hidden_tasks
  end
end
