require 'rails_helper'

RSpec.describe ScheduleHours, type: :model do
  let(:schedule_hours) { FactoryGirl.build(:schedule_hours) }

  subject { schedule_hours }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:provider) }
  it { is_expected.to belong_to(:schedule_day) }
end
