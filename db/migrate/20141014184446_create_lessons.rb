class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :subject
      t.string :room
      t.string :teacher

      t.timestamps
    end
  end
end
