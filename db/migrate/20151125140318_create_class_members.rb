class CreateClassMembers < ActiveRecord::Migration
  def change
    create_table :class_members do |t|
      t.string :first_name
      t.string :last_name
      t.integer :sclass_id

      t.timestamps
    end
  end
end
