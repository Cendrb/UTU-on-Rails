class AddHiddenOptionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_hidden_events, :boolean
    add_column :users, :show_hidden_exams, :boolean
    add_column :users, :show_hidden_tasks, :boolean
  end
end
