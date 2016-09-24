class CreateSeminarLessons < ActiveRecord::Migration
  def change
    create_table :seminar_lessons do |t|
      t.integer :seminar_id
      t.integer :serial_number
      t.integer :week_day
      t.integer :teacher_id
      t.string :room

      t.timestamps null: false
    end
  end
end
