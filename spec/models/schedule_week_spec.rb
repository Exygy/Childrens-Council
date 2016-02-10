# == Schema Information
#
# Table name: schedules_week
#
#  id   :integer          not null, primary key
#  name :text             not null
#

require 'rails_helper'

RSpec.describe ScheduleWeek, type: :model do
  let(:schedule_week) { FactoryGirl.build(:schedule_week) }

  subject { schedule_week }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to be_valid }
  it { is_expected.to have_and_belong_to_many(:providers) }
  it { is_expected.to have_and_belong_to_many(:children) }
end
