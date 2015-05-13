class AddGroupAndAdditionalInfoUrlToRakings < ActiveRecord::Migration
  def change
    add_column :rakings, :group, :integer
    add_column :rakings, :additional_info_url, :string
  end
end
