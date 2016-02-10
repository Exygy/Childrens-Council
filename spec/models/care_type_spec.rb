# == Schema Information
#
# Table name: care_types
#
#  id       :integer          not null, primary key
#  name     :text             not null
#  facility :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe CareType, type: :model do
  let(:care_type) { FactoryGirl.build(:care_type) }

  subject { care_type }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to be_valid }
  it { is_expected.to have_many(:providers) }
  it { is_expected.to have_and_belong_to_many(:children) }
end
