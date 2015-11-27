class CreateGroupBelongings < ActiveRecord::Migration
  def change
    create_table :group_belongings do |t|
      t.integer :class_member_id
      t.integer :sgroup_id

      t.timestamps
    end
  end
end
