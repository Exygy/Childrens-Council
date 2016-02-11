# == Schema Information
#
# Table name: zip_codes
#
#  id  :integer          not null, primary key
#  zip :string(5)        not null
#

require 'rails_helper'

RSpec.describe ZipCode, type: :model do
  let(:zip_code) { FactoryGirl.build(:zip_code) }

  subject { zip_code }

  it { is_expected.to validate_presence_of(:zip) }
  it { is_expected.to validate_length_of(:zip).is_equal_to(5) }
  it { is_expected.to be_valid }
  it { is_expected.to have_many(:providers) }
  it { is_expected.to have_and_belong_to_many(:parents) }
end
