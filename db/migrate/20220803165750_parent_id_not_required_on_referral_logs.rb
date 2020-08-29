class ParentIdNotRequiredOnReferralLogs < ActiveRecord::Migration
  def change
    change_column :referral_logs, :parent_id, :integer, null: true
  end
end
