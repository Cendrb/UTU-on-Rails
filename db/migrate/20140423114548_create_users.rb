class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.boolean :admin
      t.integer :group

      t.timestamps
    end
  end
end
