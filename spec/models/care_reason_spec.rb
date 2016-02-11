# == Schema Information
#
# Table name: care_reasons
#
#  id   :integer          not null, primary key
#  name :text             not null
#

require 'rails_helper'

RSpec.describe CareReason, type: :model do
  let(:reason) { FactoryGirl.build(:care_reason) }

  subject { reason }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_and_belong_to_many(:parents) }
  it { is_expected.to be_valid }
end
