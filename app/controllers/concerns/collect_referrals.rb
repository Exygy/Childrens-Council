module CollectReferrals
  extend ActiveSupport::Concern

  included do
    before_action :create_referral_log
  end

  def create_referral_log
    ReferralLog.create(
      params: params,
      parent: @current_parent,
    )
  end
end
