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

class ReferralLogSerializer < ActiveModel::Serializer
  attributes :id, :params
  has_one :parent
end
