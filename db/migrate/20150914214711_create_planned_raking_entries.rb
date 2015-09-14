class CreatePlannedRakingEntries < ActiveRecord::Migration
  def change
    create_table :planned_raking_entries do |t|
      t.string :name
      t.integer :planned_raking_list_id
      t.integer :user_id
      t.boolean :finished
      t.integer :sorting_order

      t.timestamps
    end
  end
end
