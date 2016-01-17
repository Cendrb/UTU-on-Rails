class RemoveSgroup < ActiveRecord::Migration
  def change
    remove_column :timetables, :sgroup_id, :integer
  end
end
