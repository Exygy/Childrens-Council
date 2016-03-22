class AddsForeignKeysToAssociatedTables < ActiveRecord::Migration
  def change
    add_timestamps :care_reasons_parents, null: false
    add_foreign_key :care_reasons_parents, :care_reasons
    add_foreign_key :care_reasons_parents, :parents

    add_timestamps :care_types_children, null: false
    add_foreign_key :care_types_children, :care_types
    add_foreign_key :care_types_children, :children

    add_foreign_key :children, :schedules_year, column: :schedule_year_id

    add_timestamps :children_schedule_day, null: false
    add_foreign_key :children_schedule_day, :children
    add_foreign_key :children_schedule_day, :schedules_day, column: :schedule_day_id

    add_timestamps :children_schedule_week, null: false
    add_foreign_key :children_schedule_week, :children
    add_foreign_key :children_schedule_week, :schedules_week, column: :schedule_week_id

    add_timestamps :found_options, null: false

    change_column_null :languages, :created_at, false
    change_column_null :languages, :updated_at, false

    # add_foreign_key :licenses, :providers

    add_timestamps :neighborhoods_parents, null: false
    add_foreign_key :neighborhoods_parents, :neighborhoods
    add_foreign_key :neighborhoods_parents, :parents

    add_foreign_key :parents, :found_options

    add_timestamps :parents_zip_codes, null: false
    add_foreign_key :parents_zip_codes, :parents
    add_foreign_key :parents_zip_codes, :zip_codes

    add_timestamps :programs_providers, null: false

    add_foreign_key :providers, :cities
    add_foreign_key :providers, :cities, column: :mail_city_id
    add_foreign_key :providers, :states
    add_foreign_key :providers, :states, column: :mail_state_id
    add_foreign_key :providers, :schedules_year, column: :schedule_year_id
    add_foreign_key :providers, :zip_codes
    # add_foreign_key :providers, :care_types
    add_foreign_key :providers, :neighborhoods

    # add_foreign_key :providers_schedule_week, :providers
    add_foreign_key :providers_schedule_week, :schedules_week, column: :schedule_week_id

    change_column_null :referral_logs, :parent_id, false

    # add_foreign_key :schedule_hours, :providers
    add_foreign_key :schedule_hours, :schedules_day, column: :schedule_day_id
  end
end
