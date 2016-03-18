# == Schema Information
#
# Table name: meal_types
#
#  id   :integer          not null, primary key
#  name :text             not null
#

require 'rails_helper'

RSpec.describe MealType, type: :model do
  let(:meal_type) { FactoryGirl.build(:meal_type) }

  subject { meal_type }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:meals) }
end
