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

ActiveRecord::Schema.define(version: 20160210171641) do

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

  create_table "children", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "schedule_year_id"
    t.integer  "age_year",         limit: 2, null: false
    t.integer  "age_month",        limit: 2, null: false
  end

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

  create_table "parents", force: :cascade do |t|
    t.text     "first_name",            null: false
    t.text     "last_name",             null: false
    t.citext   "email"
    t.text     "zip"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "phone",      limit: 10
  end

  create_table "providers", force: :cascade do |t|
    t.text     "name",             null: false
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
    t.text     "zip"
    t.text     "cross_street_1"
    t.text     "cross_street_2"
    t.text     "mail_address_1"
    t.text     "mail_address_2"
    t.integer  "mail_city_id"
    t.integer  "mail_state_id"
    t.text     "mail_zip"
    t.text     "ssn"
    t.text     "tax_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "schedule_year_id"
  end

  create_table "providers_schedule_week", id: false, force: :cascade do |t|
    t.integer "schedule_week_id", null: false
    t.integer "provider_id",      null: false
  end

  add_index "providers_schedule_week", ["provider_id", "schedule_week_id"], name: "index_providers_schedules_week_on_p_id_and_sw_id", using: :btree
  add_index "providers_schedule_week", ["schedule_week_id", "provider_id"], name: "index_providers_schedules_week_on_sw_id_and_p_id", unique: true, using: :btree

  create_table "schedule_hours", force: :cascade do |t|
    t.integer  "schedule_day_id", null: false
    t.integer  "provider_id",     null: false
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "closed"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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

end
