class MoreInformationConnections < ActiveRecord::Migration
  def change
    add_column :more_informations, :event_id, :integer
    add_column :more_informations, :exam_id, :integer
    add_column :more_informations, :task_id, :integer
  end
end
