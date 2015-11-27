class UtuThingsRework < ActiveRecord::Migration
  def change
    add_column :exams, :sclass_id, :integer
    add_column :events, :sclass_id, :integer
    add_column :tasks, :sclass_id, :integer
    add_column :planned_raking_lists, :sclass_id, :integer
    rename_column :exams, :group, :sgroup_id
    add_column :events, :sgroup_id, :integer
    rename_column :tasks, :group, :sgroup_id
  end
end
