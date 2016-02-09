class CreateSchedulesYear < ActiveRecord::Migration
  def change
    create_table :schedules_year do |t|
      t.text :name
      t.timestamps null: false
    end
  end
end
