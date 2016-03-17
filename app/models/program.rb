# == Schema Information
#
# Table name: programs
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class Program < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :providers
end
