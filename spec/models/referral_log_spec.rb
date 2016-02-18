# == Schema Information
#
# Table name: referral_logs
#
#  id         :integer          not null, primary key
#  params     :json
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_referral_logs_on_parent_id  (parent_id)
#

require 'rails_helper'

RSpec.describe ReferralLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
