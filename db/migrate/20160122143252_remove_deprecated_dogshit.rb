class RemoveDeprecatedDogshit < ActiveRecord::Migration
  def change
    remove_column :events, :additional_info_url
    remove_column :exams, :additional_info_url
    remove_column :tasks, :additional_info_url

    remove_column :users, :name
  end
end
