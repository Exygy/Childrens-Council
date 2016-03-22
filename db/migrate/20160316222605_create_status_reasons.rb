class CreateStatusReasons < ActiveRecord::Migration
  def change
    create_table :status_reasons do |t|
      t.text :name, null: false
      t.integer :status_type, null: false
      t.timestamps null: false
    end
  end
end
