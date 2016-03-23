class ChangeChildrenScheduleDayTableName < ActiveRecord::Migration
  def change
    rename_table :children_schedule_day, :children_schedules_day
  end
end
