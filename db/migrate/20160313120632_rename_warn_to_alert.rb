class RenameWarnToAlert < ActiveRecord::Migration
  def change
    rename_column :planned_raking_lists, :warn_when_empty, :alert_when_next_x_lessons_empty
  end
end
