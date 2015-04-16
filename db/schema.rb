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

ActiveRecord::Schema.define(version: 20150415035622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "case_contacts", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "case_documents", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_documents", ["case_id"], name: "index_case_documents_on_case_id", using: :btree
  add_index "case_documents", ["document_id"], name: "index_case_documents_on_document_id", using: :btree

  create_table "case_events", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_events", ["case_id"], name: "index_case_events_on_case_id", using: :btree
  add_index "case_events", ["event_id"], name: "index_case_events_on_event_id", using: :btree

  create_table "case_tasks", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_tasks", ["case_id"], name: "index_case_tasks_on_case_id", using: :btree
  add_index "case_tasks", ["task_id"], name: "index_case_tasks_on_task_id", using: :btree

  create_table "cases", force: :cascade do |t|
    t.string   "name"
    t.integer  "case_number"
    t.text     "description"
    t.decimal  "medical_bills",             precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "case_type"
    t.string   "subtype"
    t.integer  "user_id"
    t.date     "closing_date"
    t.string   "state",           limit: 2
    t.string   "status",                                             default: "open"
    t.string   "court"
    t.integer  "firm_id"
    t.string   "county"
    t.string   "docket_number"
    t.integer  "total_hours"
    t.string   "topic"
    t.date     "trial_date"
    t.date     "hearing_date"
    t.date     "filed_suit_date"
    t.date     "transfer_date"
  end

  add_index "cases", ["firm_id"], name: "index_cases_on_firm_id", using: :btree
  add_index "cases", ["user_id"], name: "index_cases_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "phone_number"
    t.string   "fax_number"
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
    t.string   "company"
    t.string   "corporation"
    t.string   "encrypted_ssn"
    t.datetime "date_of_birth"
    t.string   "zip_code"
    t.text     "note"
    t.boolean  "minor"
    t.date     "major_date"
    t.boolean  "deceased"
    t.date     "date_of_death"
    t.string   "company_address"
    t.string   "company_zipcode"
    t.string   "company_city"
    t.string   "company_state"
    t.string   "website"
    t.string   "mobile"
    t.string   "company_phone"
    t.string   "company_fax"
    t.string   "prefix"
  end

  add_index "contacts", ["case_id"], name: "index_contacts_on_case_id", using: :btree
  add_index "contacts", ["contact_user_id"], name: "index_contacts_on_contact_user_id", using: :btree
  add_index "contacts", ["event_id"], name: "index_contacts_on_event_id", using: :btree
  add_index "contacts", ["firm_id"], name: "index_contacts_on_firm_id", using: :btree
  add_index "contacts", ["user_account_id"], name: "index_contacts_on_user_account_id", using: :btree
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "author"
    t.string   "doc_type"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "document"
    t.integer  "firm_id"
    t.integer  "lead_id"
  end

  add_index "documents", ["firm_id"], name: "index_documents_on_firm_id", using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "event_attendees", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "display_name"
    t.boolean  "creator"
    t.string   "response_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
  end

  add_index "event_attendees", ["contact_id"], name: "index_event_attendees_on_contact_id", using: :btree
  add_index "event_attendees", ["event_id"], name: "index_event_attendees_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
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
    t.string   "html_link"
    t.string   "summary"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "end_time_unspecified"
    t.string   "transparency"
    t.string   "visibility"
    t.string   "iCalUID"
    t.integer  "sequence"
    t.integer  "firm_id"
    t.string   "google_calendar_id"
  end

  add_index "events", ["firm_id"], name: "index_events_on_firm_id", using: :btree
  add_index "events", ["google_calendar_id"], name: "index_events_on_google_calendar_id", using: :btree
  add_index "events", ["google_id"], name: "index_events_on_google_id", using: :btree
  add_index "events", ["owner_id"], name: "index_events_on_owner_id", using: :btree

  create_table "firms", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zip"
    t.string   "tenant"
    t.string   "state"
  end

  create_table "google_calendars", force: :cascade do |t|
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
    t.boolean  "active",      default: false
  end

  add_index "google_calendars", ["firm_id"], name: "index_google_calendars_on_firm_id", using: :btree
  add_index "google_calendars", ["google_id"], name: "index_google_calendars_on_google_id", using: :btree
  add_index "google_calendars", ["user_id"], name: "index_google_calendars_on_user_id", using: :btree

  create_table "incidents", force: :cascade do |t|
    t.date     "incident_date"
    t.date     "statute_of_limitations"
    t.integer  "defendant_liability"
    t.boolean  "alcohol_involved",                                default: false
    t.boolean  "weather_factor",                                  default: false
    t.decimal  "property_damage",        precision: 10, scale: 2
    t.boolean  "airbag_deployed",                                 default: false
    t.string   "speed"
    t.boolean  "police_report"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "firm_id"
    t.boolean  "towed"
    t.boolean  "complaint_at_scene"
    t.decimal  "defendant_limits"
    t.decimal  "plaintiff_limits"
    t.decimal  "uim_limits"
    t.date     "injury_date"
    t.boolean  "notice"
    t.date     "discovery_date"
    t.date     "first_sold_date"
    t.boolean  "foreign_object"
    t.date     "final_treatment_date"
  end

  add_index "incidents", ["case_id"], name: "index_incidents_on_case_id", using: :btree
  add_index "incidents", ["firm_id"], name: "index_incidents_on_firm_id", using: :btree

  create_table "injuries", force: :cascade do |t|
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
    t.decimal  "disabled_percent",   precision: 5,  scale: 2
    t.boolean  "surgery"
    t.integer  "surgery_count"
    t.string   "surgery_type"
    t.boolean  "casted_fracture"
    t.boolean  "stitches"
    t.boolean  "future_surgery"
    t.decimal  "future_medicals",    precision: 10, scale: 2
    t.integer  "firm_id"
    t.integer  "medical_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "prior_complaint"
    t.boolean  "primary_injury",                              default: false
    t.boolean  "ongoing_pain"
  end

  add_index "injuries", ["firm_id"], name: "index_injuries_on_firm_id", using: :btree
  add_index "injuries", ["medical_id"], name: "index_injuries_on_medical_id", using: :btree

  create_table "insurances", force: :cascade do |t|
    t.string   "insurance_type"
    t.string   "insurance_provider"
    t.decimal  "policy_limit"
    t.string   "claim_number"
    t.string   "policy_holder"
    t.integer  "case_id"
    t.integer  "firm_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "leads", force: :cascade do |t|
    t.integer  "screener_id"
    t.integer  "attorney_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "marketing_channel"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "email"
    t.string   "phone"
    t.date     "dob"
    t.string   "ssn"
    t.boolean  "decreased"
    t.string   "referred_by"
    t.boolean  "attorney_already"
    t.string   "attorney_name"
    t.date     "incident_date"
    t.string   "case_type"
    t.string   "sub_type"
    t.string   "primary_injury"
    t.string   "primary_region"
    t.boolean  "hospitalized"
    t.boolean  "police_report"
    t.text     "case_summary"
    t.integer  "estimated_value"
    t.string   "lead_insurance"
    t.integer  "lead_policy_limit"
    t.string   "other_insurance"
    t.integer  "other_policy_limit"
    t.string   "status",             default: "pending_review"
    t.date     "appointment_date"
    t.text     "note"
    t.integer  "firm_id"
    t.integer  "case_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "prefix"
  end

  create_table "medicals", force: :cascade do |t|
    t.decimal  "total_med_bills",            precision: 10, scale: 2
    t.decimal  "subrogated_amount",          precision: 10, scale: 2
    t.boolean  "injuries_within_three_days"
    t.integer  "length_of_treatment"
    t.string   "length_of_treatment_unit"
    t.text     "injury_summary"
    t.text     "medical_summary"
    t.decimal  "earnings_lost",              precision: 10, scale: 2
    t.boolean  "treatment_gap"
    t.boolean  "injections"
    t.boolean  "hospitalization"
    t.integer  "hospital_stay_length"
    t.string   "hospital_stay_length_unit"
    t.integer  "firm_id"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "doctor_type",                                         default: [], array: true
    t.string   "treatment_type",                                      default: [], array: true
    t.date     "injury_date"
    t.date     "final_treatment_date"
  end

  add_index "medicals", ["case_id"], name: "index_medicals_on_case_id", using: :btree
  add_index "medicals", ["firm_id"], name: "index_medicals_on_firm_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "case_id"
    t.integer  "user_id"
    t.string   "note_type"
    t.string   "author"
    t.integer  "firm_id"
  end

  add_index "notes", ["case_id"], name: "index_notes_on_case_id", using: :btree
  add_index "notes", ["firm_id"], name: "index_notes_on_firm_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "resolutions", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "firm_id"
    t.decimal  "settlement_demand", precision: 10, scale: 2
    t.decimal  "jury_demand",       precision: 10, scale: 2
    t.decimal  "resolution_amount", precision: 10, scale: 2
    t.string   "resolution_type"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "note"
    t.date     "expected_close"
    t.integer  "estimated_value"
  end

  add_index "resolutions", ["case_id"], name: "index_resolutions_on_case_id", using: :btree
  add_index "resolutions", ["firm_id"], name: "index_resolutions_on_firm_id", using: :btree

  create_table "task_drafts", force: :cascade do |t|
    t.integer "task_list_id"
    t.string  "name"
    t.integer "parent_id"
    t.text    "description"
    t.integer "due_term"
    t.string  "conjunction"
    t.string  "anchor_date"
    t.integer "number"
  end

  create_table "task_lists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "view_permission"
    t.string   "amend_permission"
    t.string   "task_import"
    t.integer  "user_id"
    t.integer  "firm_id"
    t.string   "case_type"
    t.string   "case_creator"
  end

  create_table "tasks", force: :cascade do |t|
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
    t.integer  "owner_id"
    t.decimal  "estimated_time"
    t.string   "estimated_time_unit"
    t.string   "conjunction"
    t.integer  "due_term"
    t.string   "anchor_date"
    t.integer  "parent_id"
    t.integer  "task_draft_id"
  end

  add_index "tasks", ["firm_id"], name: "index_tasks_on_firm_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "templates", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file"
    t.integer  "firm_id"
    t.text     "description"
    t.text     "html_content"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "date"
    t.decimal  "hours"
    t.integer  "case_id"
    t.text     "description"
    t.string   "charge_type"
    t.decimal  "hourly_rate"
    t.decimal  "contingent_fee"
    t.decimal  "fixed_fee"
    t.string   "aba_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_events", ["event_id"], name: "index_user_events_on_event_id", using: :btree
  add_index "user_events", ["user_id"], name: "index_user_events_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                           null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                            null: false
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
    t.string   "time_zone",              default: "Pacific Time (US & Canada)"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.integer  "invitation_role"
    t.integer  "hourly_rate"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["firm_id"], name: "index_users_on_firm_id", using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
