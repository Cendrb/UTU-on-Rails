class DestroyRaking < ActiveRecord::Migration
  def change
    drop_table :rakings
    drop_table :done_rakings
  end
end
