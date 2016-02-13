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

require 'rails_helper'

RSpec.describe LanguageProvider, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
