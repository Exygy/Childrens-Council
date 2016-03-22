class CreateProviderSubsidyJoinTable < ActiveRecord::Migration
  def change
    create_join_table :providers, :subsidies do |t|
      t.index [:provider_id, :subsidy_id], unique: true
      t.index [:subsidy_id, :provider_id]
    end

    add_foreign_key :providers_subsidies, :providers
    add_foreign_key :providers_subsidies, :subsidies
  end
end
