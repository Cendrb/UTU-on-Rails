class AddHiddenArraysToUser < ActiveRecord::Migration
  def change
    add_column :users, :hidden_events, :integer, array: true, default: []
    add_column :users, :hidden_exams, :integer, array: true, default: []
    add_column :users, :hidden_tasks, :integer, array: true, default: []
  end
end
