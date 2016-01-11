class JoinServicesWithSchoolYears < ActiveRecord::Migration
  def change
    add_column :services, :school_year_id, :integer
  end
end
