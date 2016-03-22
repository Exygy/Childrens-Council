class CreateMealTypes < ActiveRecord::Migration
  def change
    create_table :meal_types do |t|
      t.text :name, null: false
    end
  end
end
