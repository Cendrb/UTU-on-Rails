class CreateLessonTimings < ActiveRecord::Migration
  def change
    create_table :lesson_timings do |t|
      t.integer :start
      t.integer :duration
      t.integer :serial_number

      t.timestamps null: false
    end
  end
end
