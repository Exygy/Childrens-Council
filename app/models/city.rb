# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class City < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :providers
end
