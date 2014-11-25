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

ActiveRecord::Schema.define(version: 20141124121641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "attorneys", force: true do |t|
    t.string   "attorney_type", limit: 255
    t.string   "firm",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attorneys_events", id: false, force: true do |t|
    t.integer "attorney_id"
    t.integer "event_id"
  end

  create_table "case_contacts", force: true do |t|
    t.integer  "case_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "case_documents", force: true do |t|
    t.integer  "case_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_documents", ["case_id"], name: "index_case_documents_on_case_id", using: :btree
  add_index "case_documents", ["document_id"], name: "index_case_documents_on_document_id", using: :btree

  create_table "case_events", force: true do |t|
    t.integer  "case_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_events", ["case_id"], name: "index_case_events_on_case_id", using: :btree
  add_index "case_events", ["event_id"], name: "index_case_events_on_event_id", using: :btree

  create_table "case_tasks", force: true do |t|
    t.integer  "case_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "case_tasks", ["case_id"], name: "index_case_tasks_on_case_id", using: :btree
  add_index "case_tasks", ["task_id"], name: "index_case_tasks_on_task_id", using: :btree

  create_table "cases", force: true do |t|
    t.string   "name",          limit: 255
    t.integer  "case_number"
    t.text     "description"
    t.decimal  "medical_bills",             precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "case_type",     limit: 255
    t.string   "subtype",       limit: 255
    t.integer  "user_id"
    t.date     "closing_date"
    t.string   "state",         limit: 2
    t.string   "status",                                             default: "open"
    t.string   "court",         limit: 255
    t.integer  "firm_id"
    t.string   "county"
    t.string   "docket_number"
    t.integer  "total_hours"
  end

  add_index "cases", ["firm_id"], name: "index_cases_on_firm_id", using: :btree
  add_index "cases", ["user_id"], name: "index_cases_on_user_id", using: :btree

  create_table "clients", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "first_name",         limit: 255
    t.string   "middle_name",        limit: 255
    t.string   "last_name",          limit: 255
    t.string   "address",            limit: 255
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "country",            limit: 255
    t.string   "phone_number",       limit: 255
    t.integer  "fax_number"
    t.string   "email",              limit: 255
    t.string   "gender",             limit: 255
    t.integer  "age"
    t.string   "type",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "contact_user_id"
    t.integer  "case_id"
    t.boolean  "married",                        default: false
    t.boolean  "employed",                       default: false
    t.text     "job_description"
    t.decimal  "salary"
    t.boolean  "parent",                         default: false
    t.boolean  "felony_convictions",             default: false
    t.boolean  "last_ten_years",                 default: false
    t.integer  "jury_likeability"
    t.string   "witness_type",       limit: 255
    t.string   "witness_subtype",    limit: 255
    t.string   "witness_doctype",    limit: 255
    t.string   "attorney_type",      limit: 255
    t.string   "staff_type",         limit: 255
    t.integer  "event_id"
    t.integer  "firm_id"
    t.integer  "user_account_id"
    t.string   "company"
    t.boolean  "corporation",                    default: false
  end

  add_index "contacts", ["case_id"], name: "index_contacts_on_case_id", using: :btree
  add_index "contacts", ["contact_user_id"], name: "index_contacts_on_contact_user_id", using: :btree
  add_index "contacts", ["event_id"], name: "index_contacts_on_event_id", using: :btree
  add_index "contacts", ["firm_id"], name: "index_contacts_on_firm_id", using: :btree
  add_index "contacts", ["user_account_id"], name: "index_contacts_on_user_account_id", using: :btree
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

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
    t.string   "author",     limit: 255
    t.string   "doc_type",   limit: 255
    t.string   "template",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "document",   limit: 255
    t.integer  "firm_id"
  end

  add_index "documents", ["firm_id"], name: "index_documents_on_firm_id", using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "event_attendees", force: true do |t|
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

  create_table "events", force: true do |t|
    t.string   "subject",              limit: 255
    t.string   "location",             limit: 255
    t.date     "date"
    t.time     "time"
    t.boolean  "all_day",                          default: false
    t.boolean  "reminder",                         default: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.integer  "firm_id"
    t.string   "google_id"
    t.string   "etag"
    t.string   "status"
    t.string   "html_link"
    t.string   "summary"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "end_time_unspecified",             default: false
    t.string   "transparency"
    t.string   "visibility"
    t.string   "iCalUID"
    t.integer  "sequence"
    t.string   "google_calendar_id"
  end

  add_index "events", ["firm_id"], name: "index_events_on_firm_id", using: :btree
  add_index "events", ["google_calendar_id"], name: "index_events_on_google_calendar_id", using: :btree
  add_index "events", ["google_id"], name: "index_events_on_google_id", using: :btree
  add_index "events", ["owner_id"], name: "index_events_on_owner_id", using: :btree

  create_table "firms", force: true do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.string   "fax",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zip",        limit: 255
    t.string   "tenant",     limit: 255
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
    t.boolean  "active",      default: false
  end

  add_index "google_calendars", ["firm_id"], name: "index_google_calendars_on_firm_id", using: :btree
  add_index "google_calendars", ["google_id"], name: "index_google_calendars_on_google_id", using: :btree
  add_index "google_calendars", ["user_id"], name: "index_google_calendars_on_user_id", using: :btree

  create_table "incidents", force: true do |t|
    t.date     "incident_date"
    t.date     "statute_of_limitations"
    t.integer  "defendant_liability"
    t.boolean  "alcohol_involved",                                            default: false
    t.boolean  "weather_factor",                                              default: false
    t.decimal  "property_damage",                    precision: 10, scale: 2
    t.boolean  "airbag_deployed",                                             default: false
    t.string   "speed",                  limit: 255
    t.boolean  "police_report",                                               default: false
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "insurance_provider",     limit: 255
    t.integer  "firm_id"
    t.boolean  "towed",                                                       default: false
    t.boolean  "complaint_at_scene",                                          default: false
  end

  add_index "incidents", ["case_id"], name: "index_incidents_on_case_id", using: :btree
  add_index "incidents", ["firm_id"], name: "index_incidents_on_firm_id", using: :btree

  create_table "injuries", force: true do |t|
    t.string   "injury_type",        limit: 255
    t.string   "region",             limit: 255
    t.string   "code",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "medical_id"
    t.integer  "firm_id"
    t.boolean  "dominant_side",                                           default: false
    t.boolean  "joint_fracture",                                          default: false
    t.boolean  "displaced_fracture",                                      default: false
    t.boolean  "disfigurement",                                           default: false
    t.boolean  "impairment",                                              default: false
    t.boolean  "permanence",                                              default: false
    t.boolean  "disabled",                                                default: false
    t.decimal  "disabled_percent",               precision: 5,  scale: 2
    t.boolean  "surgery",                                                 default: false
    t.integer  "surgery_count"
    t.string   "surgery_type"
    t.boolean  "casted_fracture",                                         default: false
    t.boolean  "stitches",                                                default: false
    t.boolean  "future_surgery",                                          default: false
    t.decimal  "future_medicals",                precision: 10, scale: 2
    t.boolean  "prior_complaint",                                         default: false
    t.boolean  "primary_injury",                                          default: false
    t.boolean  "ongoing_pain",                                            default: false
  end

  add_index "injuries", ["firm_id"], name: "index_injuries_on_firm_id", using: :btree
  add_index "injuries", ["medical_id"], name: "index_injuries_on_medical_id", using: :btree

  create_table "medicals", force: true do |t|
    t.decimal  "total_med_bills",            precision: 10, scale: 2
    t.decimal  "subrogated_amount",          precision: 10, scale: 2
    t.boolean  "injuries_within_three_days",                          default: false
    t.integer  "length_of_treatment"
    t.string   "length_of_treatment_unit"
    t.text     "injury_summary"
    t.text     "medical_summary"
    t.decimal  "earnings_lost",              precision: 10, scale: 2
    t.boolean  "treatment_gap",                                       default: false
    t.boolean  "injections",                                          default: false
    t.boolean  "hospitalization",                                     default: false
    t.integer  "hospital_stay_length"
    t.string   "hospital_stay_length_unit"
    t.integer  "firm_id"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "doctor_type",                                         default: [],    array: true
    t.string   "treatment_type",                                      default: [],    array: true
  end

  add_index "medicals", ["case_id"], name: "index_medicals_on_case_id", using: :btree
  add_index "medicals", ["firm_id"], name: "index_medicals_on_firm_id", using: :btree

  create_table "notes", force: true do |t|
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "case_id"
    t.integer  "user_id"
    t.string   "note_type",  limit: 255
    t.string   "author",     limit: 255
    t.integer  "firm_id"
  end

  add_index "notes", ["case_id"], name: "index_notes_on_case_id", using: :btree
  add_index "notes", ["firm_id"], name: "index_notes_on_firm_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

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

  create_table "resolutions", force: true do |t|
    t.integer  "case_id"
    t.integer  "firm_id"
    t.decimal  "settlement_demand", precision: 10, scale: 2
    t.decimal  "jury_demand",       precision: 10, scale: 2
    t.decimal  "resolution_amount", precision: 10, scale: 2
    t.string   "resolution_type"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "note"
  end

  add_index "resolutions", ["case_id"], name: "index_resolutions_on_case_id", using: :btree
  add_index "resolutions", ["firm_id"], name: "index_resolutions_on_firm_id", using: :btree

  create_table "staffs", force: true do |t|
    t.string   "staff_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "name",           limit: 255
    t.date     "due_date"
    t.date     "completed"
    t.boolean  "sms_reminder",               default: false
    t.boolean  "email_reminder",             default: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "firm_id"
  end

  add_index "tasks", ["firm_id"], name: "index_tasks_on_firm_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "treatments", force: true do |t|
    t.integer  "injury_id"
    t.integer  "firm_id"
    t.boolean  "surgery"
    t.integer  "surgery_count"
    t.string   "surgery_type"
    t.boolean  "casted_fracture"
    t.boolean  "stitches"
    t.boolean  "future_surgery"
    t.decimal  "future_medicals"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_events", ["event_id"], name: "index_user_events_on_event_id", using: :btree
  add_index "user_events", ["user_id"], name: "index_user_events_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  limit: 255, default: "",                           null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,                            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "role"
    t.boolean  "show_onboarding",                    default: false
    t.string   "oauth_refresh_token",    limit: 255
    t.string   "oauth_token",            limit: 255
    t.datetime "oauth_expires_at"
    t.string   "google_email",           limit: 255
    t.integer  "firm_id"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "time_zone",                          default: "Pacific Time (US & Canada)"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                  default: 0
    t.integer  "invitation_role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["firm_id"], name: "index_users_on_firm_id", using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "witnesses", force: true do |t|
    t.string   "witness_type",    limit: 255
    t.string   "witness_subtype", limit: 255
    t.string   "witness_doctype", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
