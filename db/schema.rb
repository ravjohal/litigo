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

ActiveRecord::Schema.define(version: 20140819223709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attorneys", force: true do |t|
    t.string   "attorney_type"
    t.string   "firm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attorneys_events", id: false, force: true do |t|
    t.integer "attorney_id"
    t.integer "event_id"
  end

  create_table "cases", force: true do |t|
    t.string   "name"
    t.integer  "number"
    t.text     "description"
    t.decimal  "medical_bills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "case_type_id"
    t.integer  "subtype_id"
    t.string   "case_type"
    t.string   "subtype"
    t.integer  "user_id"
    t.string   "judje"
    t.string   "court"
    t.string   "plaintiff"
    t.string   "defendant"
    t.boolean  "corporation",   default: false
    t.string   "status"
    t.date     "creation_date"
    t.date     "closing_date"
  end

  create_table "cases_documents", id: false, force: true do |t|
    t.integer "case_id"
    t.integer "document_id"
  end

  create_table "cases_events", id: false, force: true do |t|
    t.integer "case_id"
    t.integer "event_id"
  end

  create_table "cases_tasks", id: false, force: true do |t|
    t.integer "case_id"
    t.integer "task_id"
  end

  create_table "clients", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "phone_number"
    t.integer  "fax_number"
    t.string   "email"
    t.string   "gender"
    t.integer  "age"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "defendants", force: true do |t|
    t.boolean  "married"
    t.boolean  "employed"
    t.text     "job_description"
    t.float    "salary"
    t.boolean  "parent"
    t.boolean  "felony_convictions"
    t.boolean  "last_ten_years"
    t.integer  "jury_likeability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "author"
    t.string   "doc_type"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "document"
  end

  create_table "events", force: true do |t|
    t.string   "subject"
    t.string   "location"
    t.date     "date"
    t.time     "time"
    t.boolean  "all_day"
    t.boolean  "reminder"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  create_table "events_users", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "incidents", force: true do |t|
    t.date     "incident_date"
    t.date     "statute_of_limitations"
    t.integer  "defendant_liability"
    t.boolean  "alcohol_involved",                               default: false
    t.boolean  "weather_factor",                                 default: false
    t.decimal  "property_damage",        precision: 8, scale: 2
    t.boolean  "airbag_deployed",                                default: false
    t.string   "speed"
    t.string   "police_report"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "case_id"
    t.integer  "user_id"
    t.string   "note_type"
    t.string   "author"
  end

  create_table "plantiffs", force: true do |t|
    t.boolean  "married"
    t.boolean  "employed"
    t.text     "job_description"
    t.float    "salary"
    t.boolean  "parent"
    t.boolean  "felony_convictions"
    t.boolean  "last_ten_years"
    t.integer  "jury_likeability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.date     "due_date"
    t.date     "completed"
    t.boolean  "sms_reminder"
    t.boolean  "email_reminder"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.boolean  "show_onboarding",        default: true
    t.string   "oauth_refresh_token"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "google_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "witnesses", force: true do |t|
    t.string   "witness_type"
    t.string   "witness_subtype"
    t.string   "witness_doctype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
