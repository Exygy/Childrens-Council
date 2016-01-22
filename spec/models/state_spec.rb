require 'rails_helper'

RSpec.describe State, type: :model do
  let(:state) { FactoryGirl.build(:state) }
  subject { state }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:abbr) }
  it { is_expected.to validate_uniqueness_of(:abbr) }
  it { is_expected.to validate_length_of(:abbr).is_equal_to(2) }
  it { is_expected.to be_valid }
end