# == Schema Information
#
# Table name: children
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  schedule_year_id :integer
#  age_months       :integer          not null
#  parent_id        :integer
#
# Indexes
#
#  index_children_on_parent_id         (parent_id)
#  index_children_on_schedule_year_id  (schedule_year_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id)
#  fk_rails_...  (schedule_year_id => schedules_year.id)
#

require 'rails_helper'

RSpec.describe Child, type: :model do
  let(:child) { FactoryGirl.build(:child) }

  subject { child }

  it { is_expected.to validate_presence_of(:age_months) }
  it { is_expected.to validate_inclusion_of(:age_months).in_range(0..215) }
  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:schedule_year) }
  it { is_expected.to have_and_belong_to_many(:schedule_weeks) }
  it { is_expected.to have_and_belong_to_many(:schedule_days) }
end
