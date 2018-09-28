class DropTables < ActiveRecord::Migration
  def change
    drop_table :care_reasons, force: :cascade
    drop_table :care_reasons_parents, force: :cascade
    drop_table :care_types, force: :cascade
    drop_table :care_types_parents, force: :cascade
    drop_table :children, force: :cascade
    drop_table :children_schedule_day, force: :cascade
    drop_table :children_schedule_week, force: :cascade
    drop_table :cities, force: :cascade
    drop_table :found_options, force: :cascade
    drop_table :languages, force: :cascade
    drop_table :languages_providers, force: :cascade
    drop_table :licenses, force: :cascade
    drop_table :meal_sponsors, force: :cascade
    drop_table :meal_types, force: :cascade
    drop_table :meals, force: :cascade
    drop_table :neighborhoods, force: :cascade
    drop_table :neighborhoods_parents, force: :cascade
    drop_table :parents_zip_codes, force: :cascade
    drop_table :program_types, force: :cascade
    drop_table :programs, force: :cascade
    drop_table :programs_providers, force: :cascade
    drop_table :providers, force: :cascade
    drop_table :providers_schedule_week, force: :cascade
    drop_table :providers_subsidies, force: :cascade
    drop_table :rates, force: :cascade
    drop_table :schedule_hours, force: :cascade
    drop_table :schedules_week, force: :cascade
    drop_table :schedules_year, force: :cascade
    drop_table :states, force: :cascade
    drop_table :status_reasons, force: :cascade
    drop_table :statuses, force: :cascade
    drop_table :subsidies, force: :cascade
    drop_table :versions, force: :cascade
    drop_table :zip_codes, force: :cascade
  end
end
