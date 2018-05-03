# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

# Commented out until admin interface is being built
# RSpec.describe 'Languages', type: :request do
#   describe 'GET /languages' do
#     it 'works! (now write some real specs)' do
#       get languages_path
#       expect(response).to have_http_status(200)
#     end
#   end
# end
