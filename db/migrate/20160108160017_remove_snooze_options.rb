class RemoveSnoozeOptions < ActiveRecord::Migration
  def change
    drop_table :snoozed_events
    drop_table :snoozed_exams
    drop_table :snoozed_tasks
  end
end
