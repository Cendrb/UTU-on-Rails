class AddExperimentalSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :experimental_settings, :boolean
  end
end
