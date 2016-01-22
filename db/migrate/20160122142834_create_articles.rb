class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.boolean :published
      t.integer :sclass_id
      t.integer :sgroup_id
      t.datetime :show_in_details_until

      t.timestamps
    end
  end
end
