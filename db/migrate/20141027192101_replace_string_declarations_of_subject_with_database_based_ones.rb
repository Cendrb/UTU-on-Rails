class ReplaceStringDeclarationsOfSubjectWithDatabaseBasedOnes < ActiveRecord::Migration
  def change
    remove_column :lessons, :subject
    add_column :lessons, :subject_id, :integer
    
    add_column :exams, :subject_id, :integer
    
    add_column :tasks, :subject_id, :integer
  end
end
