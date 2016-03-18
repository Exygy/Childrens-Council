class AddTimestampsToSubsidiesAndProgramTypesAndMealTypes < ActiveRecord::Migration
  def change
    add_timestamps :subsidies, null: false
    add_timestamps :providers_subsidies, null: false
    add_timestamps :program_types, null: false
    add_timestamps :meal_types, null: false
  end
end
