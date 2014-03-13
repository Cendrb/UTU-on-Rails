class FixColumnNamesInEvent < ActiveRecord::Migration
  def change
    rename_column :events, :start, :event_start
    rename_column :events, :end, :event_end
  end
end
