class CreateScheduleHours < ActiveRecord::Migration
  def change
    create_table :schedule_hours do |t|
      t.integer :schedule_day_id, null: false
      t.integer :provider_id, null: false
      t.time :start_time
      t.time :end_time
      t.boolean :closed
      t.timestamps null: false

      t.index [:schedule_day_id, :provider_id], unique: true
      t.index [:provider_id, :schedule_day_id]
    end
  end
end
