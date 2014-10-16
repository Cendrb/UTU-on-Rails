class AddChangedToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :not_normal, :boolean
  end
end
