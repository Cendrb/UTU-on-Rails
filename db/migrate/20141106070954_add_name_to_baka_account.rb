class AddNameToBakaAccount < ActiveRecord::Migration
  def change
    add_column :baka_accounts, :name, :string
  end
end
