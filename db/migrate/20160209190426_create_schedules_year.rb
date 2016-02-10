class CreateSchedulesYear < ActiveRecord::Migration
  def change
    create_table :schedules_year do |t|
      t.text :name
    end
  end
end
