class CreateSchoolYears < ActiveRecord::Migration
  def change
    create_table :school_years do |t|
      t.integer :beginning_year

      t.timestamps
    end
  end
end
