class ScheduleHours < ActiveRecord::Base
  belongs_to :provider
  belongs_to :schedule_day
end
