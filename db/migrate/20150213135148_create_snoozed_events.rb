class CreateSnoozedEvents < ActiveRecord::Migration
  def change
    create_table :snoozed_events do |t|
      t.integer :user_id
      t.datetime :snooze_date
      t.integer :event_id

      t.timestamps
    end
  end
end
