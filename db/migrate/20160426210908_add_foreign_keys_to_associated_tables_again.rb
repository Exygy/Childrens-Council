class AddForeignKeysToAssociatedTablesAgain < ActiveRecord::Migration
  def change
    add_foreign_key :care_reasons_parents, :care_reasons
    add_foreign_key :care_reasons_parents, :parents

    add_foreign_key :care_types_parents, :care_types
    add_foreign_key :care_types_parents, :parents

    add_foreign_key :children, :schedules_year, column: :schedule_year_id

    add_foreign_key :children_schedule_day, :children
    add_foreign_key :children_schedule_day, :schedules_day, column: :schedule_day_id

    add_foreign_key :children_schedule_week, :children
    add_foreign_key :children_schedule_week, :schedules_week, column: :schedule_week_id

    add_foreign_key :languages_providers, :languages
    add_foreign_key :languages_providers, :providers

    add_foreign_key :licenses, :providers

    add_foreign_key :meals, :meal_types
    add_foreign_key :meals, :providers

    add_foreign_key :neighborhoods_parents, :neighborhoods
    add_foreign_key :neighborhoods_parents, :parents

    add_foreign_key :parents, :found_options

    add_foreign_key :parents_zip_codes, :parents
    add_foreign_key :parents_zip_codes, :zip_codes

    add_foreign_key :programs, :program_types

    add_foreign_key :programs_providers, :programs
    add_foreign_key :programs_providers, :providers

    add_foreign_key :providers, :cities
    add_foreign_key :providers, :cities, column: :mail_city_id
    add_foreign_key :providers, :states
    add_foreign_key :providers, :states, column: :mail_state_id
    add_foreign_key :providers, :schedules_year, column: :schedule_year_id
    add_foreign_key :providers, :zip_codes
    add_foreign_key :providers, :care_types
    add_foreign_key :providers, :neighborhoods
    add_foreign_key :providers, :meal_sponsors
    add_foreign_key :providers, :languages, column: :preferred_language_id

    add_foreign_key :providers_schedule_week, :providers
    add_foreign_key :providers_schedule_week, :schedules_week, column: :schedule_week_id

    add_foreign_key :providers_subsidies, :providers
    add_foreign_key :providers_subsidies, :subsidies

    add_foreign_key :rates, :providers

    add_foreign_key :schedule_hours, :providers
    add_foreign_key :schedule_hours, :schedules_day, column: :schedule_day_id

    add_foreign_key :statuses, :providers
    add_foreign_key :statuses, :status_reasons
  end
end
