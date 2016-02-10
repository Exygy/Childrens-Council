class AddScheduleYearIdToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :schedule_year_id, :integer
  end
end
