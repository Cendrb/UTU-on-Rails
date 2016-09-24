class CreateSeminarBelongings < ActiveRecord::Migration
  def change
    create_table :seminar_belongings do |t|
      t.integer :class_member_id
      t.integer :seminar_id

      t.timestamps null: false
    end
  end
end
