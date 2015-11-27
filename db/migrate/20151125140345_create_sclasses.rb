class CreateSclasses < ActiveRecord::Migration
  def change
    create_table :sclasses do |t|
      t.string :name

      t.timestamps
    end
  end
end
