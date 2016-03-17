# == Schema Information
#
# Table name: statuses
#
#  id               :integer          not null, primary key
#  provider_id      :integer          not null
#  status_type      :integer          not null
#  start_date       :date
#  end_date         :date
#  status_reason_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_statuses_on_provider_id       (provider_id)
#  index_statuses_on_status_reason_id  (status_reason_id)
#

class Status < ActiveRecord::Base
  include StatusType

  belongs_to :provider
  belongs_to :status_reason
end
