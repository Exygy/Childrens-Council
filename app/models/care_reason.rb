# == Schema Information
#
# Table name: care_reasons
#
#  id   :integer          not null, primary key
#  name :text             not null
#

class CareReason < ActiveRecord::Base
  validates :name, presence: true
  has_and_belongs_to_many :parents
end
