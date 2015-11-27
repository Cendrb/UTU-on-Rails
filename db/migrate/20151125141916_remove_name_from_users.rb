class RemoveNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :group, :integer
  end
end
