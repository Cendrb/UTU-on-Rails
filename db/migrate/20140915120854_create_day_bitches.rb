class CreateDayBitches < ActiveRecord::Migration
  def change
    create_table :day_bitches do |t|
      t.date :date
      t.integer :bitch_id

      t.timestamps
    end
  end
end
