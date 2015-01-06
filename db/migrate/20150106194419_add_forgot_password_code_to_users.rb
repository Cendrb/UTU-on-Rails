class AddForgotPasswordCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forgot_password_code, :string
  end
end
