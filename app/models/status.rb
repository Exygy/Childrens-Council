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
# Foreign Keys
#
#  fk_rails_...  (provider_id => providers.id)
#  fk_rails_...  (status_reason_id => status_reasons.id)
#

class Status < ActiveRecord::Base
  include StatusType

  validates :provider, presence: true
  validates :status_type, presence: true
  validates :start_date, presence: true, if: 'temporarily_inactive? || inactive?'
  validates :start_date, absence: true, unless: 'temporarily_inactive? || inactive?'
  validates :end_date, presence: true, if: 'temporarily_inactive?'
  validates :end_date, absence: true, unless: 'temporarily_inactive?'
  validates :status_reason, presence: true, if: 'inactive?'
  validates :status_reason, absence: true, if: 'active?'

  belongs_to :provider
  belongs_to :status_reason, inverse_of: :statuses

  has_paper_trail
end
