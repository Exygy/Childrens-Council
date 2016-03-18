class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :provider, index: true, foreign_key: true, null: false
      t.integer :rate_type, null: false
      t.decimal :full_monthly, precision: 7, scale: 2
      t.decimal :full_weekly, precision: 7, scale: 2
      t.decimal :full_daily, precision: 7, scale: 2
      t.decimal :full_hourly, precision: 7, scale: 2
      t.decimal :part_monthly, precision: 7, scale: 2
      t.decimal :part_weekly, precision: 7, scale: 2
      t.decimal :part_daily, precision: 7, scale: 2
      t.decimal :part_hourly, precision: 7, scale: 2
      t.timestamps null: false
    end
  end
end
