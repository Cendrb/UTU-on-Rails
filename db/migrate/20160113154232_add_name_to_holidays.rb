class AddNameToHolidays < ActiveRecord::Migration
  def change
    add_column :holidays, :name, :string
  end
end
