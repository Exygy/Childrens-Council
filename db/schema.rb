# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160318215220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "care_reasons", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "care_reasons_parents", id: false, force: :cascade do |t|
    t.integer  "parent_id",      null: false
    t.integer  "care_reason_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "care_reasons_parents", ["care_reason_id", "parent_id"], name: "index_care_reasons_parents_on_care_reason_id_and_parent_id", unique: true, using: :btree
  add_index "care_reasons_parents", ["parent_id", "care_reason_id"], name: "index_care_reasons_parents_on_parent_id_and_care_reason_id", using: :btree

  create_table "care_types", force: :cascade do |t|
    t.text    "name",                     null: false
    t.boolean "facility", default: false
  end

  create_table "care_types_children", id: false, force: :cascade do |t|
    t.integer  "care_type_id", null: false
    t.integer  "child_id",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "care_types_children", ["care_type_id", "child_id"], name: "index_care_types_children_on_care_type_id_and_child_id", unique: true, using: :btree
  add_index "care_types_children", ["child_id", "care_type_id"], name: "index_care_types_children_on_child_id_and_care_type_id", using: :btree

  create_table "children", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "schedule_year_id"
    t.integer  "age_year",         limit: 2, null: false
    t.integer  "age_month",        limit: 2, null: false
  end

  add_index "children", ["schedule_year_id"], name: "index_children_on_schedule_year_id", using: :btree

  create_table "children_schedule_day", id: false, force: :cascade do |t|
    t.integer  "schedule_day_id", null: false
    t.integer  "child_id",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "children_schedule_day", ["child_id", "schedule_day_id"], name: "index_children_schedule_day_on_child_id_and_schedule_day_id", using: :btree
  add_index "children_schedule_day", ["schedule_day_id", "child_id"], name: "index_children_schedule_day_on_schedule_day_id_and_child_id", unique: true, using: :btree

  create_table "children_schedule_week", id: false, force: :cascade do |t|
    t.integer  "schedule_week_id", null: false
    t.integer  "child_id",         null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "children_schedule_week", ["child_id", "schedule_week_id"], name: "index_children_schedules_week_on_c_id_and_sw_id", using: :btree
  add_index "children_schedule_week", ["schedule_week_id", "child_id"], name: "index_children_schedules_week_on_sw_id_and_c_id", unique: true, using: :btree

  create_table "cities", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "found_options", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages_providers", force: :cascade do |t|
    t.integer  "language_id", null: false
    t.integer  "provider_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "languages_providers", ["language_id", "provider_id"], name: "index_languages_providers_on_language_id_and_provider_id", using: :btree
  add_index "languages_providers", ["provider_id", "language_id"], name: "index_languages_providers_on_provider_id_and_language_id", unique: true, using: :btree

  create_table "licenses", force: :cascade do |t|
    t.integer  "provider_id",                      null: false
    t.date     "date"
    t.boolean  "exempt",           default: false
    t.integer  "license_type",                     null: false
    t.text     "number"
    t.integer  "capacity"
    t.integer  "capacity_desired"
    t.integer  "capacity_subsidy"
    t.integer  "age_from_year"
    t.integer  "age_from_month"
    t.integer  "age_to_year"
    t.integer  "age_to_month"
    t.integer  "vacancies"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "licenses", ["provider_id"], name: "index_licenses_on_provider_id", using: :btree

  create_table "meal_sponsors", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_types", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.integer  "meal_type_id",                         null: false
    t.integer  "provider_id",                          null: false
    t.boolean  "provided_by_facility", default: false
    t.boolean  "provided_by_parent",   default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "meals", ["meal_type_id", "provider_id"], name: "index_meals_on_meal_type_id_and_provider_id", using: :btree
  add_index "meals", ["provider_id", "meal_type_id"], name: "index_meals_on_provider_id_and_meal_type_id", unique: true, using: :btree

  create_table "neighborhoods", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "neighborhoods_parents", id: false, force: :cascade do |t|
    t.integer  "neighborhood_id", null: false
    t.integer  "parent_id",       null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "neighborhoods_parents", ["neighborhood_id", "parent_id"], name: "index_neighborhoods_parents_on_neighborhood_id_and_parent_id", unique: true, using: :btree
  add_index "neighborhoods_parents", ["parent_id", "neighborhood_id"], name: "index_neighborhoods_parents_on_parent_id_and_neighborhood_id", using: :btree

  create_table "parents", force: :cascade do |t|
    t.text     "first_name",                 null: false
    t.text     "last_name",                  null: false
    t.citext   "email"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "phone",           limit: 10
    t.integer  "found_option_id"
    t.text     "address"
    t.string   "home_zip_code",   limit: 5
    t.string   "api_key"
    t.string   "full_name"
  end

  add_index "parents", ["found_option_id"], name: "index_parents_on_found_option_id", using: :btree

  create_table "parents_zip_codes", id: false, force: :cascade do |t|
    t.integer  "parent_id",   null: false
    t.integer  "zip_code_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "parents_zip_codes", ["parent_id", "zip_code_id"], name: "index_parents_zip_codes_on_parent_id_and_zip_code_id", using: :btree
  add_index "parents_zip_codes", ["zip_code_id", "parent_id"], name: "index_parents_zip_codes_on_zip_code_id_and_parent_id", unique: true, using: :btree

  create_table "program_types", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programs", force: :cascade do |t|
    t.text     "name",            null: false
    t.integer  "program_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "programs", ["program_type_id"], name: "index_programs_on_program_type_id", using: :btree

  create_table "programs_providers", id: false, force: :cascade do |t|
    t.integer  "program_id",  null: false
    t.integer  "provider_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "programs_providers", ["program_id", "provider_id"], name: "index_programs_providers_on_program_id_and_provider_id", using: :btree
  add_index "programs_providers", ["provider_id", "program_id"], name: "index_programs_providers_on_provider_id_and_program_id", unique: true, using: :btree

  create_table "providers", force: :cascade do |t|
    t.text     "name",                                 null: false
    t.text     "alternate_name"
    t.text     "contact_name"
    t.text     "phone"
    t.text     "phone_ext"
    t.text     "phone_other"
    t.text     "phone_other_ext"
    t.text     "fax"
    t.text     "email"
    t.text     "url"
    t.text     "address_1"
    t.text     "address_2"
    t.integer  "city_id"
    t.integer  "state_id"
    t.text     "cross_street_1"
    t.text     "cross_street_2"
    t.text     "mail_address_1"
    t.text     "mail_address_2"
    t.integer  "mail_city_id"
    t.integer  "mail_state_id"
    t.text     "ssn"
    t.text     "tax_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "schedule_year_id"
    t.integer  "zip_code_id"
    t.integer  "care_type_id"
    t.text     "description"
    t.integer  "licensed_ages",         default: [],                array: true
    t.integer  "neighborhood_id"
    t.string   "mail_zip_code"
    t.boolean  "accepting_referrals",   default: true
    t.boolean  "meals_optional",        default: true
    t.integer  "meal_sponsor_id"
    t.integer  "english_capability"
    t.integer  "preferred_language_id"
  end

  add_index "providers", ["care_type_id"], name: "index_providers_on_care_type_id", using: :btree
  add_index "providers", ["city_id"], name: "index_providers_on_city_id", using: :btree
  add_index "providers", ["mail_city_id"], name: "index_providers_on_mail_city_id", using: :btree
  add_index "providers", ["mail_state_id"], name: "index_providers_on_mail_state_id", using: :btree
  add_index "providers", ["meal_sponsor_id"], name: "index_providers_on_meal_sponsor_id", using: :btree
  add_index "providers", ["neighborhood_id"], name: "index_providers_on_neighborhood_id", using: :btree
  add_index "providers", ["preferred_language_id"], name: "index_providers_on_preferred_language_id", using: :btree
  add_index "providers", ["schedule_year_id"], name: "index_providers_on_schedule_year_id", using: :btree
  add_index "providers", ["state_id"], name: "index_providers_on_state_id", using: :btree
  add_index "providers", ["zip_code_id"], name: "index_providers_on_zip_code_id", using: :btree

  create_table "providers_schedule_week", id: false, force: :cascade do |t|
    t.integer "schedule_week_id", null: false
    t.integer "provider_id",      null: false
  end

  add_index "providers_schedule_week", ["provider_id", "schedule_week_id"], name: "index_providers_schedules_week_on_p_id_and_sw_id", using: :btree
  add_index "providers_schedule_week", ["schedule_week_id", "provider_id"], name: "index_providers_schedules_week_on_sw_id_and_p_id", unique: true, using: :btree

  create_table "providers_subsidies", id: false, force: :cascade do |t|
    t.integer  "provider_id", null: false
    t.integer  "subsidy_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "providers_subsidies", ["provider_id", "subsidy_id"], name: "index_providers_subsidies_on_provider_id_and_subsidy_id", unique: true, using: :btree
  add_index "providers_subsidies", ["subsidy_id", "provider_id"], name: "index_providers_subsidies_on_subsidy_id_and_provider_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "provider_id",                          null: false
    t.integer  "rate_type",                            null: false
    t.decimal  "full_monthly", precision: 7, scale: 2
    t.decimal  "full_weekly",  precision: 7, scale: 2
    t.decimal  "full_daily",   precision: 7, scale: 2
    t.decimal  "full_hourly",  precision: 7, scale: 2
    t.decimal  "part_monthly", precision: 7, scale: 2
    t.decimal  "part_weekly",  precision: 7, scale: 2
    t.decimal  "part_daily",   precision: 7, scale: 2
    t.decimal  "part_hourly",  precision: 7, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "rates", ["provider_id"], name: "index_rates_on_provider_id", using: :btree

  create_table "referral_logs", force: :cascade do |t|
    t.json     "params"
    t.integer  "parent_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "referral_logs", ["parent_id"], name: "index_referral_logs_on_parent_id", using: :btree

  create_table "schedule_hours", force: :cascade do |t|
    t.integer  "schedule_day_id",                 null: false
    t.integer  "provider_id",                     null: false
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "closed",          default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "open_24",         default: false
  end

  add_index "schedule_hours", ["provider_id", "schedule_day_id"], name: "index_schedule_hours_on_provider_id_and_schedule_day_id", using: :btree
  add_index "schedule_hours", ["schedule_day_id", "provider_id"], name: "index_schedule_hours_on_schedule_day_id_and_provider_id", unique: true, using: :btree

  create_table "schedules_day", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "schedules_week", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "schedules_year", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "states", force: :cascade do |t|
    t.text "name"
    t.text "abbr"
  end

  create_table "status_reasons", force: :cascade do |t|
    t.text     "name",        null: false
    t.integer  "status_type", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.integer  "provider_id",      null: false
    t.integer  "status_type",      null: false
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "status_reason_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "statuses", ["provider_id"], name: "index_statuses_on_provider_id", using: :btree
  add_index "statuses", ["status_reason_id"], name: "index_statuses_on_status_reason_id", using: :btree

  create_table "subsidies", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "zip_codes", force: :cascade do |t|
    t.string "zip", limit: 5, null: false
  end

  add_foreign_key "care_reasons_parents", "care_reasons"
  add_foreign_key "care_reasons_parents", "parents"
  add_foreign_key "care_types_children", "care_types"
  add_foreign_key "care_types_children", "children"
  add_foreign_key "children", "schedules_year", column: "schedule_year_id"
  add_foreign_key "children_schedule_day", "children"
  add_foreign_key "children_schedule_day", "schedules_day", column: "schedule_day_id"
  add_foreign_key "children_schedule_week", "children"
  add_foreign_key "children_schedule_week", "schedules_week", column: "schedule_week_id"
  add_foreign_key "languages_providers", "languages"
  add_foreign_key "languages_providers", "providers"
  add_foreign_key "meals", "meal_types"
  add_foreign_key "meals", "providers"
  add_foreign_key "neighborhoods_parents", "neighborhoods"
  add_foreign_key "neighborhoods_parents", "parents"
  add_foreign_key "parents", "found_options"
  add_foreign_key "parents_zip_codes", "parents"
  add_foreign_key "parents_zip_codes", "zip_codes"
  add_foreign_key "programs", "program_types"
  add_foreign_key "programs_providers", "programs"
  add_foreign_key "programs_providers", "providers"
  add_foreign_key "providers", "cities"
  add_foreign_key "providers", "cities", column: "mail_city_id"
  add_foreign_key "providers", "languages", column: "preferred_language_id"
  add_foreign_key "providers", "meal_sponsors"
  add_foreign_key "providers", "neighborhoods"
  add_foreign_key "providers", "schedules_year", column: "schedule_year_id"
  add_foreign_key "providers", "states"
  add_foreign_key "providers", "states", column: "mail_state_id"
  add_foreign_key "providers", "zip_codes"
  add_foreign_key "providers_schedule_week", "schedules_week", column: "schedule_week_id"
  add_foreign_key "providers_subsidies", "providers"
  add_foreign_key "providers_subsidies", "subsidies"
  add_foreign_key "rates", "providers"
  add_foreign_key "referral_logs", "parents"
  add_foreign_key "schedule_hours", "schedules_day", column: "schedule_day_id"
  add_foreign_key "statuses", "providers"
  add_foreign_key "statuses", "status_reasons"
end
