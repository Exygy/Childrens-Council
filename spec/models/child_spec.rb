# == Schema Information
#
# Table name: children
#
#  id         :integer          not null, primary key
#  age        :integer          not null
#  zip        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Child, type: :model do
  let(:child) { FactoryGirl.build(:child) }

  subject { child }

  it { is_expected.to validate_presence_of(:age_year) }
  it { is_expected.to validate_inclusion_of(:age_year).in_range(1...18) }
  it { is_expected.to validate_presence_of(:age_month) }
  it { is_expected.to validate_inclusion_of(:age_month).in_range(1..12) }
  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:schedule_year) }
  it { is_expected.to have_and_belong_to_many(:schedule_week) }
  it { is_expected.to have_and_belong_to_many(:schedule_days) }
end
