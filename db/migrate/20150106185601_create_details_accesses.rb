class CreateDetailsAccesses < ActiveRecord::Migration
  def change
    create_table :details_accesses do |t|
      t.integer :user_id
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
  end
end
