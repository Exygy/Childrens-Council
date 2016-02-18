class CreateReferralLogs < ActiveRecord::Migration
  def change
    create_table :referral_logs do |t|
      t.json :params
      t.references :parent, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
