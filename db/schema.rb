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

ActiveRecord::Schema.define(version: 20160105203735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "children", force: :cascade do |t|
    t.integer  "age",        null: false
    t.text     "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "parents", force: :cascade do |t|
    t.text     "first_name", null: false
    t.text     "last_name",  null: false
    t.citext   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: :cascade do |t|
    t.text     "name",            null: false
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
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "states", force: :cascade do |t|
    t.text "name"
    t.text "abbr"
  end

end
