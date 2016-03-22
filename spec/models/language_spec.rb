# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Language, type: :model do
  let(:language) { FactoryGirl.build(:language) }

  subject { language }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_and_belong_to_many(:providers) }
end
