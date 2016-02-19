# == Schema Information
#
# Table name: schedule_hours
#
#  id              :integer          not null, primary key
#  schedule_day_id :integer          not null
#  provider_id     :integer          not null
#  start_time      :time
#  end_time        :time
#  closed          :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  open_24         :boolean          default(FALSE)
#
# Indexes
#
#  index_schedule_hours_on_provider_id_and_schedule_day_id  (provider_id,schedule_day_id)
#  index_schedule_hours_on_schedule_day_id_and_provider_id  (schedule_day_id,provider_id) UNIQUE
#

require 'rails_helper'

RSpec.describe ScheduleHours, type: :model do
  let(:schedule_hours) { FactoryGirl.build(:schedule_hours) }

  subject { schedule_hours }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:provider) }
  it { is_expected.to belong_to(:schedule_day) }
end
