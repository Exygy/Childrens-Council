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
  has_and_belongs_to_many :children, join_table: 'children_schedule_day'
  has_many :schedule_hours, class_name: 'ScheduleHours'
  has_many :providers, through: :schedule_hours
end
