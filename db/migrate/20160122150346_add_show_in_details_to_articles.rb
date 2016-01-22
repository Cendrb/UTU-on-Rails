class AddShowInDetailsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :show_in_details, :boolean
  end
end
