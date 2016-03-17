# == Schema Information
#
# Table name: program_types
#
#  id   :integer          not null, primary key
#  name :text             not null
#

require 'rails_helper'

RSpec.describe ProgramType, type: :model do
  let(:program_type) { FactoryGirl.build(:program_type) }

  subject { program_type }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:programs) }
end
