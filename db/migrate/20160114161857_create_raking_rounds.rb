class CreateRakingRounds < ActiveRecord::Migration
  def change
    create_table :raking_rounds do |t|
      t.integer :planned_raking_list_id
      t.integer :school_year_id

      t.timestamps
    end
  end
end
