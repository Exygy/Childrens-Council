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

FactoryGirl.define do
  factory :meal do
    association :meal_type
    association :provider

    factory :meal_by_facility do
      provided_by_facility true
    end

    factory :meal_by_parent do
      provided_by_parent true
    end

    factory :meal_by_facility_or_parent do
      provided_by_facility true
      provided_by_parent true
    end
  end
end
