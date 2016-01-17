class AddNumberToRakingRounds < ActiveRecord::Migration
  def change
    add_column :raking_rounds, :number, :integer
  end
end
