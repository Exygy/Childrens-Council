# == Schema Information
#
# Table name: meals
#
#  id                   :integer          not null, primary key
#  meal_type_id         :integer          not null
#  provider_id          :integer          not null
#  provided_by_facility :boolean          default(FALSE)
#  provided_by_parent   :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_meals_on_meal_type_id_and_provider_id  (meal_type_id,provider_id)
#  index_meals_on_provider_id_and_meal_type_id  (provider_id,meal_type_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (meal_type_id => meal_types.id)
#  fk_rails_...  (provider_id => providers.id)
#

require 'rails_helper'

RSpec.describe Meal, type: :model do
  let(:meal) { FactoryGirl.build(:meal) }

  subject { meal }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:meal_type) }
  it { is_expected.to validate_presence_of(:provider) }

  it { is_expected.to belong_to(:provider) }
  it { is_expected.to belong_to(:meal_type) }
end
