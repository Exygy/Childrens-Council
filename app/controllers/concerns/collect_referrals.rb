module CollectReferrals
  extend ActiveSupport::Concern

  included do
    before_action :create_referral_log
  end

  def create_referral_log
    referral_log_params = { params: params, ip_address: request.remote_ip }
    referral_log_params[:parent] = @current_parent if @current_parent

    ReferralLog.create(referral_log_params)
  end
end
