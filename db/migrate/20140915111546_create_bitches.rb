class CreateBitches < ActiveRecord::Migration
  def change
    create_table :bitches do |t|
      t.string :name
      t.text :description
      t.integer :group

      t.timestamps
    end
  end
end
