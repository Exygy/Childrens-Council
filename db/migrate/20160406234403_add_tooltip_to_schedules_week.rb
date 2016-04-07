class AddTooltipToSchedulesWeek < ActiveRecord::Migration
  def change
    add_column :schedules_week, :tooltip, :string
  end
end
