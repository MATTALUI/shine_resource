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

ActiveRecord::Schema.define(version: 20181207040334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.string "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "caretakers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "password_digest"
    t.string "organization_id"
    t.boolean "master", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone_info", default: "Mountain Time (US & Canada)|-7"
    t.string "password_reset_token", limit: 69
    t.index ["email"], name: "index_caretakers_on_email"
    t.index ["organization_id"], name: "index_caretakers_on_organization_id"
    t.index ["password_reset_token"], name: "index_caretakers_on_password_reset_token", unique: true
  end

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "organization_id", null: false
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
    t.index ["organization_id"], name: "index_clients_on_organization_id"
  end

  create_table "incedent_reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "note_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_incedent_reports_on_note_id"
  end

  create_table "incident_reports", force: :cascade do |t|
    t.string "note_id"
    t.string "client_id"
    t.string "caretaker_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caretaker_id"], name: "index_incident_reports_on_caretaker_id"
    t.index ["client_id"], name: "index_incident_reports_on_client_id"
    t.index ["note_id"], name: "index_incident_reports_on_note_id"
  end

  create_table "memos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "client_id", null: false
    t.string "caretaker_id", null: false
    t.text "encrypted_body"
    t.text "encrypted_body_iv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caretaker_id"], name: "index_memos_on_caretaker_id"
    t.index ["client_id"], name: "index_memos_on_client_id"
  end

  create_table "note_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "caretaker_id"
    t.time "start_time"
    t.time "end_time"
    t.date "date"
    t.integer "total_hours"
    t.boolean "billed_for"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caretaker_id"], name: "index_note_groups_on_caretaker_id"
  end

  create_table "notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "client_id"
    t.time "start_time"
    t.time "end_time"
    t.text "service_description"
    t.integer "transportation_trips"
    t.string "location"
    t.string "interactions"
    t.text "support_provided"
    t.text "comments"
    t.string "note_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_notes_on_client_id"
    t.index ["note_group_id"], name: "index_notes_on_note_group_id"
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone_info", default: "Mountain Time (US & Canada)|-7"
    t.string "color", default: "yellow"
  end

  create_table "presets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "caretaker_id", null: false
    t.string "client_id"
    t.string "preset_type"
    t.text "text", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_code"
    t.index ["caretaker_id"], name: "index_presets_on_caretaker_id"
    t.index ["client_id"], name: "index_presets_on_client_id"
  end

end
