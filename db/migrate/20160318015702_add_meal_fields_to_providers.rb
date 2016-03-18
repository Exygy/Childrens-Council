class AddMealFieldsToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :meals_optional, :boolean, default: true
    add_reference :providers, :meal_sponsor, index: true, foreign_key: true
  end
end
