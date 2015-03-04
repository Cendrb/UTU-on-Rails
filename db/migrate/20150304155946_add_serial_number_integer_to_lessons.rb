class AddSerialNumberIntegerToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :serial_number, :integer
  end
end
