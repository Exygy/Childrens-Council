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

require 'rails_helper'

RSpec.describe Status, type: :model do
  let(:active_status) { FactoryGirl.build(:active_status) }
  let(:temporarily_inactive_status) { FactoryGirl.build(:temporarily_inactive_status) }
  let(:inactive_status) { FactoryGirl.build(:inactive_status) }

  subject { active_status }

  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:status_type) }
  it { is_expected.to belong_to(:provider) }
  it { is_expected.to belong_to(:status_reason) }
  it { is_expected.to be_valid }

  context 'has active status type' do
    subject { active_status }

    it { is_expected.to validate_absence_of(:start_date) }
    it { is_expected.to validate_absence_of(:end_date) }
    it { is_expected.to validate_absence_of(:status_reason) }
  end

  context 'has temporarily_inactive status_type' do
    subject { temporarily_inactive_status }

    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
  end

  context 'has inactive status_type' do
    subject { inactive_status }

    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_absence_of(:end_date) }
    it { is_expected.to validate_presence_of(:status_reason) }
  end
end
