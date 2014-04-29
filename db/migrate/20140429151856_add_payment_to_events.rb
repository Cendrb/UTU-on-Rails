class AddPaymentToEvents < ActiveRecord::Migration
  def change
    add_column :events, :pay_date, :date
    add_column :events, :price, :integer
  end
end
