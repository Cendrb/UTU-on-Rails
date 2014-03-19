class AddAdditionalInfoUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :additional_info_url, :string
  end
end
