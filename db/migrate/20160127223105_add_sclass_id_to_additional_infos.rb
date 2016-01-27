class AddSclassIdToAdditionalInfos < ActiveRecord::Migration
  def change
    add_column :additional_infos, :sclass_id, :integer
  end
end
