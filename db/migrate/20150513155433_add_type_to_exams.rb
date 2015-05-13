class AddTypeToExams < ActiveRecord::Migration
  def change
    add_column :exams, :type, :string
  end
end
