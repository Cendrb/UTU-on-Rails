class RemoveColumnsMoreInfoUrlFromDetails < ActiveRecord::Migration
  def change
    remove_column :exams, :additional_info_url, :string
    remove_column :events, :additional_info_url, :string
    remove_column :tasks, :additional_info_url, :string
  end
end
