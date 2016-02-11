# == Schema Information
#
# Table name: schedules_week
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class ScheduleWeek < ActiveRecord::Base
  self.table_name = 'schedules_week'
  validates :name, presence: true
  has_and_belongs_to_many :children, join_table: 'children_schedule_week'
  has_and_belongs_to_many :providers, join_table: 'providers_schedule_week'
end
