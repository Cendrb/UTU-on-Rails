class AddTimetableAbbrToSgroups < ActiveRecord::Migration
  def change
    add_column :sgroups, :timetable_abbr, :string
  end
end
