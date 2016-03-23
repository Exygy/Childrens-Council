class ChildrenScheduleDay < ActiveRecord::Base
  belongs_to :child
  belongs_to :schedule_day
end
