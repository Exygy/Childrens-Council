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

require 'rails_helper'

RSpec.describe Status, type: :model do
  let(:status) { FactoryGirl.build(:status) }

  subject { status }

  it { is_expected.to belong_to(:provider) }
  it { is_expected.to belong_to(:status_reason) }
  it { is_expected.to be_valid }
end
