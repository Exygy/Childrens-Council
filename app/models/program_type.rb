# == Schema Information
#
# Table name: program_types
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class ProgramType < ActiveRecord::Base
  validates :name, presence: true
  has_many :programs
end
