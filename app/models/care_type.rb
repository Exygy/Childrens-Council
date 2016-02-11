# == Schema Information
#
# Table name: care_types
#
#  id       :integer          not null, primary key
#  name     :text             not null
#  facility :boolean          default(FALSE)
#

class CareType < ActiveRecord::Base
  validates :name, presence: true
  has_many :providers
  has_and_belongs_to_many :children
end
