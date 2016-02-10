class ScheduleYear < ActiveRecord::Base
  self.table_name = 'schedules_year'
  validates :name, presence: true
  has_many :children
  has_many :providers
end
