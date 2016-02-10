class AddScheduleYearIdToChild < ActiveRecord::Migration
  def change
    add_column :children, :schedule_year_id, :integer
  end
end
