class CreateSchedulesDay < ActiveRecord::Migration
  def change
    create_table :schedules_day do |t|
      t.text :name, null: false
    end
  end
end
