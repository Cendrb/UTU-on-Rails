class RemoveHiddenDogshitFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :show_hidden_events
    remove_column :users, :show_hidden_exams
    remove_column :users, :show_hidden_tasks
  end
end
