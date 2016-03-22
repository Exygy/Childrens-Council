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

require 'rails_helper'

RSpec.describe Rate, type: :model do
  let(:rate) { FactoryGirl.build(:rate) }

  subject { rate }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:rate_type) }

  it { is_expected.to belong_to(:provider) }
end
