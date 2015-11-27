class ServicesRework < ActiveRecord::Migration
  def change
    remove_column :services, :first_name
    remove_column :services, :second_name
    add_column :services, :sclass_id, :integer
    add_column :services, :first_mate_id, :integer
    add_column :services, :second_mate_id, :integer
  end
end
