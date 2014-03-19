class AddAdditionalInfoUrlToExams < ActiveRecord::Migration
  def change
    add_column :exams, :additional_info_url, :string
  end
end
