class AddClassMemberIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :class_member_id, :integer
  end
end
