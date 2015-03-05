class AddAbbrToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :abbr, :string
  end
end
