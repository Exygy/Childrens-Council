# == Schema Information
#
# Table name: subsidies
#
#  id   :integer          not null, primary key
#  name :text             not null
#

require 'rails_helper'

RSpec.describe Subsidy, type: :model do
  let(:subsidy) { FactoryGirl.build(:subsidy) }

  subject { subsidy }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_and_belong_to_many(:providers) }
  it { is_expected.to be_valid }
end
