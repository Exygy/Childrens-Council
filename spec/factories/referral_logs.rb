# == Schema Information
#
# Table name: referral_logs
#
#  id         :integer          not null, primary key
#  params     :json
#  parent_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_referral_logs_on_parent_id  (parent_id)
#

FactoryGirl.define do
  factory :referral_log do
    params ""
parent nil
  end

end
