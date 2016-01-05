require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:provider) { FactoryGirl.build(:provider) }

  subject { provider }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to be_valid }
end
