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

class Meal < ActiveRecord::Base
  validates :meal_type, presence: true
  validates :provider, presence: true

  belongs_to :provider, inverse_of: :meals
  belongs_to :meal_type, inverse_of: :meals
end
