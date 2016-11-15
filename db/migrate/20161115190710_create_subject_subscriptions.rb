class CreateSubjectSubscriptions < ActiveRecord::Migration
  def change
    create_table :subject_subscriptions do |t|
      t.integer :subject_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
