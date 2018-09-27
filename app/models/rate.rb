# == Schema Information
#
# Table name: rates
#
#  id           :integer          not null, primary key
#  provider_id  :integer          not null
#  rate_type    :integer          not null
#  full_monthly :decimal(7, 2)
#  full_weekly  :decimal(7, 2)
#  full_daily   :decimal(7, 2)
#  full_hourly  :decimal(7, 2)
#  part_monthly :decimal(7, 2)
#  part_weekly  :decimal(7, 2)
#  part_daily   :decimal(7, 2)
#  part_hourly  :decimal(7, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_rates_on_provider_id  (provider_id)
#
# Foreign Keys
#
#  fk_rails_...  (provider_id => providers.id)
#

class Rate < ActiveRecord::Base
  enum rate_type: {
    infant: 0,
    preschool: 1,
    school_age: 2,
  }

  validates :provider, presence: true
  validates :rate_type, presence: true

  belongs_to :provider, inverse_of: :rates
end
