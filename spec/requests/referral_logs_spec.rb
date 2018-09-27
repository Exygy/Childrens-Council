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

require 'rails_helper'

RSpec.describe "ReferralLogs", type: :request do
  describe "GET /referral_logs" do
    it "works! (now write some real specs)" do
      get referral_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
