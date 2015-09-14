class CreatePlannedRakingLists < ActiveRecord::Migration
  def change
    create_table :planned_raking_lists do |t|
      t.string :title
      t.text :description
      t.integer :subject_id
      t.date :beginning

      t.timestamps
    end
  end
end
