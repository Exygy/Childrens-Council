class ScheduleDay < ActiveRecord::Base
  self.table_name = 'schedules_day'
  enum day_of_week: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
  }

  validates :day_of_week, presence: true, inclusion: { in: 0..6 }
  belongs_to :provider
end
