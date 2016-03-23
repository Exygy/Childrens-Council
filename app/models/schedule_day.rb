# == Schema Information
#
# Table name: schedules_day
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class ScheduleDay < ActiveRecord::Base
  self.table_name = 'schedules_day'
  validates :name, presence: true

  # has_many :children, through: 'children_schedule_day'
  has_many :children_schedule_days
  has_many :children, through: :children_schedule_days

  has_many :schedule_hours, class_name: 'ScheduleHours', inverse_of: :schedule_day
  has_many :providers, through: :schedule_hours
end
