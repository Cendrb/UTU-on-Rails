class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :title
      t.text :description
      t.string :subject
      t.date :date
      t.integer :group

      t.timestamps
    end
  end
end
