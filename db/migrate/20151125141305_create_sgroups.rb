class CreateSgroups < ActiveRecord::Migration
  def change
    create_table :sgroups do |t|
      t.string :name
      t.integer :group_category_id

      t.timestamps
    end
  end
end
