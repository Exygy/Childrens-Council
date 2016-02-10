require 'rails_helper'

RSpec.describe License, type: :model do
  let(:license) { FactoryGirl.build(:license) }

  subject { license }

  it { is_expected.to validate_inclusion_of(:age_from_year).in_range(1...18) }
  it { is_expected.to validate_inclusion_of(:age_to_year).in_range(1...18) }
  it { is_expected.to validate_inclusion_of(:age_to_month).in_range(1..12) }
  it { is_expected.to validate_inclusion_of(:age_to_month).in_range(1..12) }
  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:provider) }
end
