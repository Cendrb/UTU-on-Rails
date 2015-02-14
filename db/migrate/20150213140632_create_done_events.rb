class CreateDoneEvents < ActiveRecord::Migration
  def change
    create_table :done_events do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
