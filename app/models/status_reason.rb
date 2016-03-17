# == Schema Information
#
# Table name: status_reasons
#
#  id          :integer          not null, primary key
#  name        :text             not null
#  status_type :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StatusReason < ActiveRecord::Base
  include StatusType

  validates :name, presence: true
  validates :status_type, presence: true

  has_many :statuses, inverse_of: :status_reason
end
