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

ActiveRecord::Schema.define(version: 20180928220255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "favorites", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "favorites", ["parent_id", "provider_id"], name: "index_favorites_on_parent_id_and_provider_id", unique: true, using: :btree

  create_table "parents", force: :cascade do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.citext   "email"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "phone",                  limit: 10
    t.integer  "found_option_id"
    t.text     "address"
    t.string   "home_zip_code",          limit: 5
    t.string   "api_key"
    t.string   "full_name"
    t.float    "random_seed"
    t.string   "near_address"
    t.boolean  "subscribe"
    t.string   "nds_client_uid"
    t.string   "provider",                          default: "email"
    t.text     "uid",                               default: ""
    t.text     "tokens"
    t.string   "encrypted_password",                default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "allow_password_change",             default: false,   null: false
  end

  add_index "parents", ["found_option_id"], name: "index_parents_on_found_option_id", using: :btree
  add_index "parents", ["uid", "provider"], name: "index_parents_on_uid_and_provider", using: :btree

  create_table "referral_logs", force: :cascade do |t|
    t.json     "params"
    t.integer  "parent_id",                      null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "child_age_months"
    t.integer  "schedule_week_ids", default: [],              array: true
    t.integer  "schedule_year_id"
    t.integer  "care_reason_ids",   default: [],              array: true
  end

  add_index "referral_logs", ["parent_id"], name: "index_referral_logs_on_parent_id", using: :btree

  add_foreign_key "favorites", "parents", on_delete: :cascade
  add_foreign_key "referral_logs", "parents"
end
