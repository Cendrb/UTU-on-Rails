class CreateSnoozedTasks < ActiveRecord::Migration
  def change
    create_table :snoozed_tasks do |t|
      t.integer :user_id
      t.datetime :snooze_date
      t.integer :task_id

      t.timestamps
    end
  end
end
