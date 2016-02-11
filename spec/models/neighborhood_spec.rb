# == Schema Information
#
# Table name: neighborhoods
#
#  id   :integer          not null, primary key
#  name :text             not null
#

require 'rails_helper'

RSpec.describe Neighborhood, type: :model do
  let(:neighborhood) { FactoryGirl.build(:neighborhood) }

  subject { neighborhood }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to be_valid }
  it { is_expected.to have_many(:providers) }
  it { is_expected.to have_and_belong_to_many(:parents) }
end
