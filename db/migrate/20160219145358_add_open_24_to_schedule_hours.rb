class AddOpen24ToScheduleHours < ActiveRecord::Migration
  def change
    add_column :schedule_hours, :open_24, :boolean, default: false
  end
end
