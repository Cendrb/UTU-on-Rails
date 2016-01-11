class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.date :holiday_beginning
      t.date :holiday_end
      t.integer :school_year_id

      t.timestamps
    end
  end
end
