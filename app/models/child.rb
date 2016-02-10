# == Schema Information
#
# Table name: children
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  schedule_year_id :integer
#  age_year         :integer          not null
#  age_month        :integer          not null
#
# Indexes
#
#  index_children_on_schedule_year_id  (schedule_year_id)
#

class Child < ActiveRecord::Base
  validates :age_year, presence: true, inclusion: { in: 1...18 }
  validates :age_month, presence: true, inclusion: { in: 1..12 }
  has_and_belongs_to_many :care_types
  belongs_to :schedule_year
  has_and_belongs_to_many :schedule_week, join_table: 'children_schedule_week'
  has_and_belongs_to_many :schedule_days, join_table: 'children_schedule_day'
end
