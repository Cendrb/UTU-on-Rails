class AddSubjectIdToAdditionalInfos < ActiveRecord::Migration
  def change
    add_column :additional_infos, :subject_id, :integer
  end
end
