class CreateMealSponsors < ActiveRecord::Migration
  def change
    create_table :meal_sponsors do |t|
      t.text :name, null: false
      t.timestamps null: false
    end
  end
end
