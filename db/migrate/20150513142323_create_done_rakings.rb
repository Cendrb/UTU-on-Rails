class CreateDoneRakings < ActiveRecord::Migration
  def change
    create_table :done_rakings do |t|
      t.integer :user_id
      t.integer :raking_id

      t.timestamps
    end
  end
end
