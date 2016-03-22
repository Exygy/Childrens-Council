# == Schema Information
#
# Table name: meal_sponsors
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe MealSponsor, type: :model do
  let(:meal_sponsor) { FactoryGirl.build(:meal_sponsor) }

  subject { meal_sponsor }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:providers) }
end
