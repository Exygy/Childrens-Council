class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.references :meal_type, foreign_key: true, null: false
      t.references :provider, foreign_key: true, null: false
      t.boolean :provided_by_facility, default: false
      t.boolean :provided_by_parent, default: false
      t.timestamps null: false
    end

    add_index :meals, [:provider_id, :meal_type_id], unique: true
    add_index :meals, [:meal_type_id, :provider_id]
  end
end
