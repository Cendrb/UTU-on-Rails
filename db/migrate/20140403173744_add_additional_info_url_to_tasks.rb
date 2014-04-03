class AddAdditionalInfoUrlToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :additional_info_url, :string
  end
end
