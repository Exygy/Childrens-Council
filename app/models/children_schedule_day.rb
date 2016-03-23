class ChildrenScheduleDay < ActiveRecord::Base
  self.table_name = "children_schedule_day"

  belongs_to :child
  belongs_to :schedule_day
end
