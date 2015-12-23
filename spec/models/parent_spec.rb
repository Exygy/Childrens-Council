require 'rails_helper'

RSpec.describe Parent, type: :model do
  let(:parent) { FactoryGirl.build(:parent) }

  subject { parent }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to be_valid }
end
