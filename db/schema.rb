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

ActiveRecord::Schema.define(version: 20180906023739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "caretakers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.boolean "master", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_caretakers_on_email"
  end

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_initial", limit: 1, null: false
    t.string "encrypted_dob"
    t.string "encrypted_dob_iv"
    t.string "encrypted_addr1"
    t.string "encrypted_addr1_iv"
    t.string "encrypted_addr2"
    t.string "encrypted_addr2_iv"
    t.string "town"
    t.string "state", limit: 2
    t.text "encrypted_description"
    t.text "encrypted_description_iv"
    t.text "encrypted_services_needed"
    t.text "encrypted_services_needed_iv"
    t.text "encrypted_ideal_provider"
    t.text "encrypted_ideal_provider_iv"
    t.text "encrypted_important_to_me"
    t.text "encrypted_important_to_me_iv"
    t.text "encrypted_important_for_me"
    t.text "encrypted_important_for_me_iv"
    t.text "encrypted_additional_info"
    t.text "encrypted_additional_info_iv"
    t.text "encrypted_shine_services"
    t.text "encrypted_shine_services_iv"
    t.string "encrypted_photo_url"
    t.string "encrypted_photo_url_iv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incedent_reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memos", force: :cascade do |t|
    t.string "client_id", null: false
    t.string "caretaker_id", null: false
    t.text "encrypted_body"
    t.text "encrypted_body_iv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caretaker_id"], name: "index_memos_on_caretaker_id"
    t.index ["client_id"], name: "index_memos_on_client_id"
  end

  create_table "notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "client_id"
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.integer "total_hours"
    t.text "service_description"
    t.integer "transportation_trips"
    t.string "location"
    t.string "interactions"
    t.text "support_provided"
    t.text "comments"
    t.boolean "incedent_reports_filed"
    t.bigint "incedent_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_notes_on_client_id"
    t.index ["incedent_report_id"], name: "index_notes_on_incedent_report_id"
  end

end
