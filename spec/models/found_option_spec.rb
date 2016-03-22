# == Schema Information
#
# Table name: found_options
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe FoundOption, type: :model do
  let(:found_option) { FactoryGirl.build(:found_option) }

  subject { found_option }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:parents) }
  it { is_expected.to be_valid }
end
