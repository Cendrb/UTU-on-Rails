class AddUserIdToDayBitches < ActiveRecord::Migration
  def change
    add_column :day_bitches, :user_id, :integer
  end
end
