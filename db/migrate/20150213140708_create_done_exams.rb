class CreateDoneExams < ActiveRecord::Migration
  def change
    create_table :done_exams do |t|
      t.integer :user_id
      t.integer :exam_id

      t.timestamps
    end
  end
end
