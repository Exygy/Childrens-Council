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

ActiveRecord::Schema.define(version: 20160219145358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "care_reasons", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "care_reasons_parents", id: false, force: :cascade do |t|
    t.integer "parent_id",      null: false
    t.integer "care_reason_id", null: false
  end

  add_index "care_reasons_parents", ["care_reason_id", "parent_id"], name: "index_care_reasons_parents_on_care_reason_id_and_parent_id", unique: true, using: :btree
  add_index "care_reasons_parents", ["parent_id", "care_reason_id"], name: "index_care_reasons_parents_on_parent_id_and_care_reason_id", using: :btree

  create_table "care_types", force: :cascade do |t|
    t.text    "name",                     null: false
    t.boolean "facility", default: false
  end

  create_table "care_types_children", id: false, force: :cascade do |t|
    t.integer "care_type_id", null: false
    t.integer "child_id",     null: false
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
    t.integer "schedule_day_id", null: false
    t.integer "child_id",        null: false
  end

  add_index "children_schedule_day", ["child_id", "schedule_day_id"], name: "index_children_schedule_day_on_child_id_and_schedule_day_id", using: :btree
  add_index "children_schedule_day", ["schedule_day_id", "child_id"], name: "index_children_schedule_day_on_schedule_day_id_and_child_id", unique: true, using: :btree

  create_table "children_schedule_week", id: false, force: :cascade do |t|
    t.integer "schedule_week_id", null: false
    t.integer "child_id",         null: false
  end

  add_index "children_schedule_week", ["child_id", "schedule_week_id"], name: "index_children_schedules_week_on_c_id_and_sw_id", using: :btree
  add_index "children_schedule_week", ["schedule_week_id", "child_id"], name: "index_children_schedules_week_on_sw_id_and_c_id", unique: true, using: :btree

  create_table "cities", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "found_options", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "language_providers", force: :cascade do |t|
    t.integer  "language_id"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "level"
  end

  add_index "language_providers", ["provider_id"], name: "index_language_providers_on_provider_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "licenses", force: :cascade do |t|
    t.integer  "provider_id",      null: false
    t.date     "date"
    t.boolean  "exempt"
    t.integer  "type"
    t.text     "number"
    t.integer  "capacity"
    t.integer  "capacity_desired"
    t.integer  "capacity_subsidy"
    t.integer  "age_from_year"
    t.integer  "age_from_month"
    t.integer  "age_to_year"
    t.integer  "age_to_month"
    t.integer  "vacancies"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "licenses", ["provider_id"], name: "index_licenses_on_provider_id", using: :btree

  create_table "neighborhoods", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "neighborhoods_parents", id: false, force: :cascade do |t|
    t.integer "neighborhood_id", null: false
    t.integer "parent_id",       null: false
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
  end

  add_index "parents", ["found_option_id"], name: "index_parents_on_found_option_id", using: :btree

  create_table "parents_zip_codes", id: false, force: :cascade do |t|
    t.integer "parent_id",   null: false
    t.integer "zip_code_id", null: false
  end

  add_index "parents_zip_codes", ["parent_id", "zip_code_id"], name: "index_parents_zip_codes_on_parent_id_and_zip_code_id", using: :btree
  add_index "parents_zip_codes", ["zip_code_id", "parent_id"], name: "index_parents_zip_codes_on_zip_code_id_and_parent_id", unique: true, using: :btree

  create_table "providers", force: :cascade do |t|
    t.text     "name",                          null: false
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
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "schedule_year_id"
    t.integer  "zip_code_id"
    t.integer  "care_type_id"
    t.text     "description"
    t.integer  "licensed_ages",    default: [],              array: true
    t.integer  "neighborhood_id"
    t.string   "mail_zip_code"
  end

  add_index "providers", ["care_type_id"], name: "index_providers_on_care_type_id", using: :btree
  add_index "providers", ["city_id"], name: "index_providers_on_city_id", using: :btree
  add_index "providers", ["mail_city_id"], name: "index_providers_on_mail_city_id", using: :btree
  add_index "providers", ["mail_state_id"], name: "index_providers_on_mail_state_id", using: :btree
  add_index "providers", ["neighborhood_id"], name: "index_providers_on_neighborhood_id", using: :btree
  add_index "providers", ["schedule_year_id"], name: "index_providers_on_schedule_year_id", using: :btree
  add_index "providers", ["state_id"], name: "index_providers_on_state_id", using: :btree
  add_index "providers", ["zip_code_id"], name: "index_providers_on_zip_code_id", using: :btree

  create_table "providers_schedule_week", id: false, force: :cascade do |t|
    t.integer "schedule_week_id", null: false
    t.integer "provider_id",      null: false
  end

  add_index "providers_schedule_week", ["provider_id", "schedule_week_id"], name: "index_providers_schedules_week_on_p_id_and_sw_id", using: :btree
  add_index "providers_schedule_week", ["schedule_week_id", "provider_id"], name: "index_providers_schedules_week_on_sw_id_and_p_id", unique: true, using: :btree

  create_table "referral_logs", force: :cascade do |t|
    t.json     "params"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "referral_logs", ["parent_id"], name: "index_referral_logs_on_parent_id", using: :btree

  create_table "schedule_hours", force: :cascade do |t|
    t.integer  "schedule_day_id",                 null: false
    t.integer  "provider_id",                     null: false
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "closed"
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

  add_foreign_key "language_providers", "providers"
  add_foreign_key "referral_logs", "parents"
end
