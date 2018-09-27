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

class Program < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :program_type
  has_and_belongs_to_many :providers
end
