class CreateSchoolDays < ActiveRecord::Migration
  def change
    create_table :school_days do |t|
      t.date :date
      t.integer :weekday

      t.timestamps
    end
  end
end
