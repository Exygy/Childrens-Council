class CreateSchedulesWeek < ActiveRecord::Migration
  def change
    create_table :schedules_week do |t|
      t.text :name, null: false
    end
  end
end
