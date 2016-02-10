class CreateScheduleWeekJoinTables < ActiveRecord::Migration
  def change
    create_join_table :schedule_week, :providers do |t|
      t.index [:schedule_week_id, :provider_id], unique: true, name: 'index_providers_schedules_week_on_sw_id_and_p_id'
      t.index [:provider_id, :schedule_week_id], name: 'index_providers_schedules_week_on_p_id_and_sw_id'
    end

    create_join_table :schedule_week, :children do |t|
      t.index [:schedule_week_id, :child_id], unique: true, name: 'index_children_schedules_week_on_sw_id_and_c_id'
      t.index [:child_id, :schedule_week_id], name: 'index_children_schedules_week_on_c_id_and_sw_id'
    end
  end
end
