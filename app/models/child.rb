# == Schema Information
#
# Table name: children
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  schedule_year_id :integer
#  age_months       :integer          not null
#  parent_id        :integer
#
# Indexes
#
#  index_children_on_parent_id         (parent_id)
#  index_children_on_schedule_year_id  (schedule_year_id)
#

class Child < ActiveRecord::Base
  validates :age_months, presence: true, inclusion: { in: 0..215 }

  has_and_belongs_to_many :care_types
  has_and_belongs_to_many :schedule_weeks, join_table: 'children_schedule_week'
  has_and_belongs_to_many :schedule_days, join_table: 'children_schedule_day'

  accepts_nested_attributes_for :children_schedule_days, :children_schedule_weeks, :children_care_types

  belongs_to :schedule_year
  belongs_to :parent
end
