require 'rails_helper'

RSpec.describe ScheduleDay, type: :model do
  let(:schedule_day) { FactoryGirl.build(:schedule_day) }

  subject { schedule_day }

  it { is_expected.to validate_presence_of(:day_of_week) }
  it { is_expected.to validate_inclusion_of(:day_of_week).in_range(0..6) }
  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:provider) }
end
