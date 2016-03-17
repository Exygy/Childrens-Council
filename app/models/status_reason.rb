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

  has_many :statuses
end
