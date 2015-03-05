class AddIsActionToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :action, :string
  end
end
