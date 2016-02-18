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

class ReferralLogSerializer < ActiveModel::Serializer
  attributes :id, :params
  has_one :parent
end
