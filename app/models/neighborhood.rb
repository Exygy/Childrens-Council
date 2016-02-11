# == Schema Information
#
# Table name: neighborhoods
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class Neighborhood < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :parents
  has_many :providers
end
