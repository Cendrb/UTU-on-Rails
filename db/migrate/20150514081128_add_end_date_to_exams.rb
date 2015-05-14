class AddEndDateToExams < ActiveRecord::Migration
  def change
    add_column :exams, :end_date, :date
  end
end
