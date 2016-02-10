require 'rails_helper'

RSpec.describe ScheduleDay, type: :model do
  let(:schedule_day) { FactoryGirl.build(:schedule_day) }

  subject { schedule_day }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to be_valid }
  it { is_expected.to have_and_belong_to_many(:children) }
  it { is_expected.to have_many(:schedule_hours) }
  it { is_expected.to have_many(:providers) }
end
