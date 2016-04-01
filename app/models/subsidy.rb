# == Schema Information
#
# Table name: subsidies
#
#  id          :integer          not null, primary key
#  name        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class Subsidy < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :providers
end
