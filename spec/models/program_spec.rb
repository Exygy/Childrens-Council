# == Schema Information
#
# Table name: programs
#
#  id   :integer          not null, primary key
#  name :text             not null
#

require 'rails_helper'

RSpec.describe Program, type: :model do
  let(:program) { FactoryGirl.build(:program) }

  subject { program }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_and_belong_to_many(:providers) }
end
