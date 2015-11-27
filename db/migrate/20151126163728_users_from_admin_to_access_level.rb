class UsersFromAdminToAccessLevel < ActiveRecord::Migration
  def change
    remove_column :users, :admin, :boolean
    add_column :users, :access_level, :integer
  end
end
