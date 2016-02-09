class ScheduleYear < ActiveRecord::Base
  self.table_name = 'schedules_year'
  has_many :children
  has_many :providers
end
