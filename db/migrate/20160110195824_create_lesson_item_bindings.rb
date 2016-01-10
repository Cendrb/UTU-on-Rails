class CreateLessonItemBindings < ActiveRecord::Migration
  def change
    create_table :lesson_item_bindings do |t|
      t.integer :lesson_id
      t.integer :item_id
      t.string :item_type

      t.timestamps
    end
  end
end
