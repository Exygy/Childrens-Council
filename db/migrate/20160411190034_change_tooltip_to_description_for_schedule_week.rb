class ChangeTooltipToDescriptionForScheduleWeek < ActiveRecord::Migration
  def change
    remove_column :schedules_week, :tooltip
    add_column :schedules_week, :description, :text
  end
end
