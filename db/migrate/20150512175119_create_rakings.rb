class CreateRakings < ActiveRecord::Migration
  def change
    create_table :rakings do |t|
      t.date :end
      t.integer :subject_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
