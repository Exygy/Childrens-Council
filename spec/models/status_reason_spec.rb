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

require 'rails_helper'

RSpec.describe StatusReason, type: :model do
  let(:status_reason) { FactoryGirl.build(:status_reason) }

  subject { status_reason }

  it { is_expected.to have_many(:statuses) }
  it { is_expected.to be_valid }
end
