require 'rails_helper'

RSpec.describe ScheduleYear, type: :model do
  let(:schedule_year) { FactoryGirl.build(:schedule_year) }

  subject { schedule_year }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:providers) }
  it { is_expected.to have_many(:children) }
end
