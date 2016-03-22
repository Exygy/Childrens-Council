class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.references :provider, index: true, foreign_key: true, null: false
      t.integer :status_type, null: false
      t.date :start_date
      t.date :end_date
      t.references :status_reason, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
