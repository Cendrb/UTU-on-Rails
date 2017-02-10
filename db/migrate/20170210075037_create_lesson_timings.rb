class CreateLessonTimings < ActiveRecord::Migration
  def change
    create_table :lesson_timings do |t|
      t.time :start
      t.time :duration
      t.integer :serial_number

      t.timestamps null: false
    end
  end
end
