class CreateSchedulesDay < ActiveRecord::Migration
  def change
    create_table :schedules_day do |t|
      t.integer :day_of_week, null: false, limit: 1
      t.time :start_time
      t.time :end_time
      t.boolean :closed
      t.timestamps null: false
    end

    add_reference :schedules_day, :provider, index: true
  end
end
