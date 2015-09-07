class CreateInfoItemBindings < ActiveRecord::Migration
  def change
    create_table :info_item_bindings do |t|
      t.integer :additional_info_id
      t.integer :item_id
      t.string :item_type

      t.timestamps
    end
  end
end
