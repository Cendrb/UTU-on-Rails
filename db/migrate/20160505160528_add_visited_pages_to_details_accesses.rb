class AddVisitedPagesToDetailsAccesses < ActiveRecord::Migration
  def change
    add_column :details_accesses, :visited_pages, :string, array: true, default: []
  end
end
