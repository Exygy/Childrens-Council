# == Schema Information
#
# Table name: children
#
#  id         :integer          not null, primary key
#  age        :integer          not null
#  zip        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Child < ActiveRecord::Base
  belongs_to :schedule_year
  has_and_belongs_to_many :schedule_week, join_table: 'children_schedule_week'
  has_and_belongs_to_many :schedule_days, join_table: 'children_schedule_day'
end
