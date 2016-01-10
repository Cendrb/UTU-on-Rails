class RemoveOldDoneFromDb < ActiveRecord::Migration
  def change
    drop_table :done_events
    drop_table :done_exams
    drop_table :done_tasks
  end
end
