# == Schema Information
#
# Table name: programs
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  program_type_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_programs_on_program_type_id  (program_type_id)
#

require 'rails_helper'

RSpec.describe Program, type: :model do
  let(:program) { FactoryGirl.build(:program) }

  subject { program }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:program_type) }
  it { is_expected.to have_and_belong_to_many(:providers) }
end
