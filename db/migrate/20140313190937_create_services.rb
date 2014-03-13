class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :first_name
      t.string :second_name
      t.date :service_start
      t.date :service_end

      t.timestamps
    end
  end
end
