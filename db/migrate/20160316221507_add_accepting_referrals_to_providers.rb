class AddAcceptingReferralsToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :accepting_referrals, :boolean
  end
end
