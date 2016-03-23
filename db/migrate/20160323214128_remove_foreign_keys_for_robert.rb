class RemoveForeignKeysForRobert < ActiveRecord::Migration
  def up
    remove_foreign_key :care_reasons_parents, :care_reasons
    remove_foreign_key :care_reasons_parents, :parents

    remove_foreign_key :care_types_children, :care_types
    remove_foreign_key :care_types_children, :children

    remove_foreign_key :children, :schedule_year # , column: :schedule_year_id

    remove_foreign_key :children_schedule_day, :children
    remove_foreign_key :children_schedule_day, :schedule_day # , column: :schedule_day_id

    remove_foreign_key :children_schedule_week, :children
    remove_foreign_key :children_schedule_week, :schedule_week # , column: :schedule_week_id

    remove_foreign_key :languages_providers, :languages
    remove_foreign_key :languages_providers, :providers

    remove_foreign_key :meals, :meal_types
    remove_foreign_key :meals, :providers

    # remove_foreign_key :licenses, :providers

    remove_foreign_key :neighborhoods_parents, :neighborhoods
    remove_foreign_key :neighborhoods_parents, :parents

    remove_foreign_key :parents, :found_options

    remove_foreign_key :parents_zip_codes, :parents
    remove_foreign_key :parents_zip_codes, :zip_codes

    remove_foreign_key :programs, :program_types

    remove_foreign_key :programs_providers, :programs
    remove_foreign_key :programs_providers, :providers

    remove_foreign_key :providers, :cities
    remove_foreign_key :providers, :mail_city # , column: :mail_city_id
    remove_foreign_key :providers, :states
    remove_foreign_key :providers, :mail_state # , column: :mail_state_id
    remove_foreign_key :providers, :schedule_year # , column: :schedule_year_id
    remove_foreign_key :providers, :zip_codes
    # remove_foreign_key :providers, :care_types
    remove_foreign_key :providers, :neighborhoods
    remove_foreign_key :providers, :meal_sponsors
    remove_foreign_key :providers, :preferred_language

    # remove_foreign_key :providers_schedule_week, :providers
    remove_foreign_key :providers_schedule_week, :schedule_week # , column: :schedule_week_id

    remove_foreign_key :providers_subsidies, :providers
    remove_foreign_key :providers_subsidies, :subsidies

    remove_foreign_key :rates, :providers

    # remove_foreign_key :schedule_hours, :providers
    remove_foreign_key :schedule_hours, :schedule_day # , column: :schedule_day_id

    remove_foreign_key :statuses, :providers
    remove_foreign_key :statuses, :status_reasons
  end

  def down
    add_foreign_key :care_reasons_parents, :care_reasons
    add_foreign_key :care_reasons_parents, :parents

    add_foreign_key :care_types_children, :care_types
    add_foreign_key :care_types_children, :children

    add_foreign_key :children, :schedules_year, column: :schedule_year_id

    add_foreign_key :children_schedule_day, :children
    add_foreign_key :children_schedule_day, :schedules_day, column: :schedule_day_id

    add_foreign_key :children_schedule_week, :children
    add_foreign_key :children_schedule_week, :schedules_week, column: :schedule_week_id

    add_foreign_key :languages_providers, :languages
    add_foreign_key :languages_providers, :providers

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
    add_foreign_key :providers, :neighborhoods
    add_foreign_key :providers, :meal_sponsors
    add_foreign_key :providers, :languages, column: :preferred_language_id

    add_foreign_key :providers_schedule_week, :schedules_week, column: :schedule_week_id

    add_foreign_key :providers_subsidies, :providers
    add_foreign_key :providers_subsidies, :subsidies

    add_foreign_key :rates, :providers

    add_foreign_key :schedule_hours, :schedules_day, column: :schedule_day_id

    add_foreign_key :statuses, :providers
    add_foreign_key :statuses, :status_reasons
  end
end
