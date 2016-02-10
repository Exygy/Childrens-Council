class CreateScheduleDayJoinTable < ActiveRecord::Migration
  def change
    create_join_table :schedule_day, :children do |t|
      t.index [:schedule_day_id, :child_id], unique: true
      t.index [:child_id, :schedule_day_id]
    end
  end
end
