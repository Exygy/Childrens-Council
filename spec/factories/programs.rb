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
# Foreign Keys
#
#  fk_rails_...  (program_type_id => program_types.id)
#

FactoryGirl.define do
  factory :program do
    name Faker::Company.catch_phrase
  end
end
