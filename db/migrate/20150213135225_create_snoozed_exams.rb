class CreateSnoozedExams < ActiveRecord::Migration
  def change
    create_table :snoozed_exams do |t|
      t.integer :user_id
      t.datetime :snooze_date
      t.integer :exam_id

      t.timestamps
    end
  end
end
