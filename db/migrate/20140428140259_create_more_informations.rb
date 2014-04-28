class CreateMoreInformations < ActiveRecord::Migration
  def change
    create_table :more_informations do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
