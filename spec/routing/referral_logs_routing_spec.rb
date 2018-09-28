# == Schema Information
#
# Table name: referral_logs
#
#  id                :integer          not null, primary key
#  params            :json
#  parent_id         :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  child_age_months  :integer
#  schedule_week_ids :integer          default([]), is an Array
#  schedule_year_id  :integer
#  care_reason_ids   :integer          default([]), is an Array
#
# Indexes
#
#  index_referral_logs_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id)
#

# ROUTE DOES NOT EXIST FOR NOW
# require 'rails_helper'
#
# RSpec.describe ReferralLogsController, type: :routing do
#   describe 'routing' do
#
#     it 'routes to #index' do
#       expect(get: '/referral_logs').to route_to('referral_logs#index')
#     end
#
#     it 'routes to #new' do
#       expect(get: '/referral_logs/new').to route_to('referral_logs#new')
#     end
#
#     it 'routes to #show' do
#       expect(get: '/referral_logs/1').to route_to('referral_logs#show', id: '1')
#     end
#
#     it 'routes to #edit' do
#       expect(get: '/referral_logs/1/edit').to route_to('referral_logs#edit', id: '1')
#     end
#
#     it 'routes to #create' do
#       expect(post: '/referral_logs').to route_to('referral_logs#create')
#     end
#
#     it 'routes to #update via PUT' do
#       expect(put: '/referral_logs/1').to route_to('referral_logs#update', id: '1')
#     end
#
#     it 'routes to #update via PATCH' do
#       expect(patch: '/referral_logs/1').to route_to('referral_logs#update', id: '1')
#     end
#
#     it 'routes to #destroy' do
#       expect(delete: '/referral_logs/1').to route_to('referral_logs#destroy', id: '1')
#     end
#
#   end
# end
