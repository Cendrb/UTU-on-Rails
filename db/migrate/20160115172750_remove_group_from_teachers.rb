class RemoveGroupFromTeachers < ActiveRecord::Migration
  def change
    remove_column :teachers, :group
  end
end
