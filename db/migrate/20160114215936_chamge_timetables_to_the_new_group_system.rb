class ChamgeTimetablesToTheNewGroupSystem < ActiveRecord::Migration
  def change
    add_column :sclasses, :default_timetable_id, :integer
    add_column :timetables, :sgroup_id, :integer
    add_column :timetables, :sclass_id, :integer
    remove_column :timetables, :group
    remove_column :baka_accounts, :name
    add_column :baka_accounts, :class_member_id, :integer
  end
end
