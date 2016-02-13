# == Schema Information
#
# Table name: language_providers
#
#  id          :integer          not null, primary key
#  language_id :integer
#  provider_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  level       :string
#
# Indexes
#
#  index_language_providers_on_provider_id  (provider_id)
#

FactoryGirl.define do
  factory :language_provider do
    language nil
    provider nil
  end

end
