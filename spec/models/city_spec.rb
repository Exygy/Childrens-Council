require 'rails_helper'

RSpec.describe City, type: :model do
  let(:city) { FactoryGirl.build(:city) }

  subject { city }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to have_many(:providers) }
end
