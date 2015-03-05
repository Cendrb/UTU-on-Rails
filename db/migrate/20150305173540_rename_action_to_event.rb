class RenameActionToEvent < ActiveRecord::Migration
  def change
    remove_column :lessons, :action
    add_column :lessons, :event_name, :string
  end
end
