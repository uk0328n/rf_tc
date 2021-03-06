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

ActiveRecord::Schema.define(version: 20180708042426) do

  create_table "activities", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "event_id"
    t.integer "attendance_type"
    t.integer "editor_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "advisor_id"
    t.integer "person_id"
    t.integer "fixed_role_type"
    t.index ["customer_id", "event_id"], name: "index_activities_on_customer_id_and_event_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.integer "role_type", default: 3, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "advisors", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "company"
    t.string "company_short_name"
    t.string "position"
    t.string "postal_code"
    t.string "address"
    t.string "tel"
    t.string "fax"
    t.string "email"
    t.string "contact_person_name"
    t.string "contact_postal_code"
    t.string "contact_address"
    t.string "contact_tel"
    t.string "contact_fax"
    t.string "contact_email"
    t.integer "editor_code"
    t.boolean "is_disable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kana", default: "", null: false
    t.integer "person_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "kana"
    t.string "short_name"
    t.string "short_name_kana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "editor_code"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "rank"
    t.string "name", default: "", null: false
    t.string "company"
    t.string "company_short_name"
    t.string "position"
    t.string "postal_code"
    t.string "address"
    t.string "tel"
    t.string "fax"
    t.string "email"
    t.string "contact_person_name"
    t.string "contact_postal_code"
    t.string "contact_address"
    t.string "contact_tel"
    t.string "contact_fax"
    t.string "contact_email"
    t.integer "editor_code"
    t.boolean "is_disable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kana", default: "", null: false
    t.integer "person_id"
  end

  create_table "event_details", force: :cascade do |t|
    t.integer "event_id"
    t.integer "advisor_id"
    t.integer "attendance_type"
    t.integer "editor_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_id", "event_id"], name: "index_event_details_on_advisor_id_and_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.date "event_date", null: false
    t.string "venue", default: "", null: false
    t.integer "capacity", default: 0, null: false
    t.integer "editor_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_fixed"
  end

  create_table "people", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "advisor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_type"
    t.integer "rank"
    t.string "name"
    t.string "kana"
    t.string "company"
    t.string "company_kana"
    t.string "company_short_name"
    t.string "position"
    t.string "postal_code"
    t.string "address"
    t.string "tel"
    t.string "fax"
    t.string "email"
    t.string "contact_person_name"
    t.string "contact_postal_code"
    t.string "contact_address"
    t.string "contact_tel"
    t.string "contact_fax"
    t.string "contact_email"
    t.string "editor_code"
    t.integer "company_id"
    t.index ["advisor_id"], name: "index_people_on_advisor_id", unique: true
    t.index ["customer_id"], name: "index_people_on_customer_id", unique: true
  end

end
