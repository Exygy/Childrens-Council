class AddIpAddressToReferralLogs < ActiveRecord::Migration
  def change
    add_column :referral_logs, :ip_address, :string, null: true
  end
end
