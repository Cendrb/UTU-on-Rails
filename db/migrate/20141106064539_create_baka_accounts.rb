class CreateBakaAccounts < ActiveRecord::Migration
  def change
    create_table :baka_accounts do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
