class CreateSeminars < ActiveRecord::Migration
  def change
    create_table :seminars do |t|
      t.string :name
      t.integer :subject_id

      t.timestamps null: false
    end
  end
end
