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

ActiveRecord::Schema.define(version: 20141020170925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "case_documents", force: true do |t|
    t.integer  "case_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "case_events", force: true do |t|
    t.integer  "case_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "case_tasks", force: true do |t|
    t.integer  "case_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cases", force: true do |t|
    t.string   "name"
    t.integer  "case_number"
    t.text     "description"
    t.decimal  "medical_bills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "case_type"
    t.string   "subtype"
    t.integer  "user_id"
    t.date     "closing_date"
    t.string   "state",         limit: 2
    t.string   "status",                  default: "0"
    t.string   "court"
    t.integer  "firm_id"
    t.string   "county"
    t.string   "docket_number"
    t.integer  "total_hours"
  end

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "phone_number"
    t.integer  "fax_number"
    t.string   "email"
    t.string   "gender"
    t.integer  "age"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "contact_user_id"
    t.integer  "case_id"
    t.boolean  "married"
    t.boolean  "employed"
    t.text     "job_description"
    t.decimal  "salary"
    t.boolean  "parent"
    t.boolean  "felony_convictions"
    t.boolean  "last_ten_years"
    t.integer  "jury_likeability"
    t.string   "witness_type"
    t.string   "witness_subtype"
    t.string   "witness_doctype"
    t.string   "attorney_type"
    t.string   "staff_type"
    t.integer  "event_id"
    t.integer  "firm_id"
    t.integer  "user_account_id"
  end

  create_table "documents", force: true do |t|
    t.string   "author"
    t.string   "doc_type"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "document"
    t.integer  "firm_id"
  end

  create_table "event_attendees", force: true do |t|
    t.integer  "event_id"
    t.string   "display_name"
    t.string   "email"
    t.boolean  "creator"
    t.string   "response_status"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "google_id"
    t.string   "etag"
    t.string   "status"
    t.string   "htmlLink"
    t.string   "summary"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "endTimeUnspecified"
    t.string   "transparency"
    t.string   "visibility"
    t.string   "iCalUID"
    t.integer  "sequence"
    t.integer  "firm_id"
    t.string   "google_calendar_id"
  end

  create_table "firms", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zip"
    t.string   "tenant"
  end

  create_table "google_calendars", force: true do |t|
    t.string   "etag"
    t.string   "google_id"
    t.string   "summary"
    t.string   "description"
    t.string   "timeZone"
    t.boolean  "selected"
    t.boolean  "primary"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "firm_id"
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
    t.string   "insurance_provider"
    t.integer  "firm_id"
    t.boolean  "towed"
    t.boolean  "complaint_at_scene"
  end

  create_table "injuries", force: true do |t|
    t.string   "injury_type"
    t.string   "region"
    t.string   "code"
    t.boolean  "dominant_side"
    t.boolean  "joint_fracture"
    t.boolean  "displaced_fracture"
    t.boolean  "disfigurement"
    t.boolean  "impairment"
    t.boolean  "permanence"
    t.boolean  "disabled"
    t.decimal  "disabled_percent"
    t.boolean  "surgery"
    t.integer  "surgery_count"
    t.string   "surgery_type"
    t.boolean  "casted_fracture"
    t.boolean  "stitches"
    t.boolean  "future_surgery"
    t.decimal  "future_medicals"
    t.integer  "firm_id"
    t.integer  "medical_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medicals", force: true do |t|
    t.decimal  "total_med_bills"
    t.decimal  "subrogated_amount"
    t.boolean  "injuries_within_three_days"
    t.integer  "length_of_treatment"
    t.string   "length_of_treatment_unit"
    t.hstore   "doctor_type"
    t.hstore   "treatment_type"
    t.text     "injury_summary"
    t.text     "medical_summary"
    t.decimal  "earnings_lost"
    t.boolean  "treatment_gap"
    t.boolean  "injections"
    t.boolean  "hospitalization"
    t.integer  "hospital_stay_length"
    t.string   "hospital_stay_length_unit"
    t.integer  "firm_id"
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
    t.integer  "firm_id"
  end

  create_table "resolutions", force: true do |t|
    t.integer  "case_id"
    t.integer  "firm_id"
    t.decimal  "settlement_demand"
    t.decimal  "jury_demand"
    t.decimal  "resolution_amount"
    t.string   "resolution_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
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
    t.integer  "firm_id"
  end

  create_table "user_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "firm_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "time_zone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
