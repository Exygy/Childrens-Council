class AddChildAgeMonthsScheduleWeekIdsScheduleYearIdCareReasonIdsToReferrals < ActiveRecord::Migration
  def change
    add_column :referral_logs, :child_age_months, :integer
    add_column :referral_logs, :schedule_week_ids, :integer, array: true, default: []
    add_column :referral_logs, :schedule_year_id, :integer
    add_column :referral_logs, :care_reason_ids, :integer, array: true, default: [] 
  end
end
