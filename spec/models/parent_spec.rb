require 'rails_helper'

RSpec.describe Parent, type: :model do
  before { @parent = FactoryGirl.build(:parent) }

  subject { @parent }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should be_valid }
end
