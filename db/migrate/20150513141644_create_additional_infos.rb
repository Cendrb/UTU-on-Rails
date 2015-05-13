class CreateAdditionalInfos < ActiveRecord::Migration
  def change
    create_table :additional_infos do |t|
      t.string :name
      t.text :url
      t.integer :task_id
      t.integer :exam_id
      t.integer :raking_id
      t.integer :event_id

      t.timestamps
    end
  end
end
