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

ActiveRecord::Schema.define(version: 20151026094004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "attorneys", force: :cascade do |t|
    t.string   "attorney_type", limit: 255
    t.string   "firm",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attorneys_events", id: false, force: :cascade do |t|
    t.integer "attorney_id"
    t.integer "event_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string  "description"
    t.string  "calendar_id"
    t.string  "name"
    t.integer "namespace_id"
    t.string  "nylas_namespace_id"
    t.boolean "active"
    t.integer "firm_id"
    t.boolean "deleted",            default: false
  end

  add_index "calendars", ["deleted"], name: "index_calendars_on_deleted", using: :btree
  add_index "calendars", ["firm_id"], name: "index_calendars_on_firm_id", using: :btree
  add_index "calendars", ["namespace_id"], name: "index_calendars_on_namespace_id", using: :btree

  create_table "case_contacts", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "firm_id"
    t.text     "note"
    t.integer  "source"
  end

  add_index "case_contacts", ["case_id"], name: "index_case_contacts_on_case_id", using: :btree
  add_index "case_contacts", ["firm_id"], name: "index_case_contacts_on_firm_id", using: :btree
  add_index "case_contacts", ["role"], name: "index_case_contacts_on_role", using: :btree

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
    t.string   "name",                   limit: 255
    t.integer  "case_number"
    t.text     "description"
    t.decimal  "medical_bills",                      precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "case_type",              limit: 255
    t.string   "subtype",                limit: 255
    t.integer  "user_id"
    t.date     "closing_date"
    t.string   "state",                  limit: 2
    t.string   "status",                                                      default: "Active"
    t.string   "court",                  limit: 255
    t.integer  "firm_id"
    t.string   "county"
    t.string   "docket_number"
    t.integer  "total_hours"
    t.string   "topic"
    t.date     "trial_date"
    t.date     "hearing_date"
    t.date     "filed_suit_date"
    t.date     "transfer_date"
    t.date     "statute_of_limitations"
    t.integer  "sol_priority"
    t.integer  "lead_id"
    t.boolean  "fee_agreement",                                               default: false
  end

  add_index "cases", ["case_type"], name: "index_cases_on_case_type", using: :btree
  add_index "cases", ["firm_id"], name: "index_cases_on_firm_id", using: :btree
  add_index "cases", ["subtype"], name: "index_cases_on_subtype", using: :btree
  add_index "cases", ["user_id"], name: "index_cases_on_user_id", using: :btree

  create_table "company_olds", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "phone"
    t.string   "fax"
    t.string   "state"
    t.string   "city"
    t.string   "zipcode"
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "firm_id"
    t.integer  "user_id"
    t.string   "fax_1"
    t.string   "fax_2"
    t.string   "phone_2"
    t.string   "phone_1"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "middle_name",        limit: 255
    t.string   "last_name",          limit: 255
    t.string   "address",            limit: 255
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "country",            limit: 255
    t.string   "phone_number",       limit: 255
    t.string   "fax_number"
    t.string   "email",              limit: 255
    t.string   "gender",             limit: 255
    t.integer  "age"
    t.string   "type",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
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
    t.boolean  "corporation",                    default: false
    t.string   "encrypted_ssn"
    t.datetime "date_of_birth"
    t.string   "zip_code"
    t.text     "note"
    t.boolean  "minor"
    t.date     "major_date"
    t.boolean  "deceased"
    t.date     "date_of_death"
    t.string   "website"
    t.string   "mobile"
    t.string   "prefix"
    t.integer  "company_id"
    t.integer  "user_account_id"
    t.string   "time_bound"
    t.string   "fax_number_1"
    t.string   "fax_number_2"
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.string   "company_name"
    t.string   "extension"
    t.string   "address_2"
    t.string   "suffix"
  end

  add_index "contacts", ["case_id"], name: "index_contacts_on_case_id", using: :btree
  add_index "contacts", ["firm_id"], name: "index_contacts_on_firm_id", using: :btree
  add_index "contacts", ["type"], name: "index_contacts_on_type", using: :btree
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "author",           limit: 255
    t.string   "doc_type",         limit: 255
    t.string   "template",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "document",         limit: 255
    t.integer  "firm_id"
    t.integer  "lead_id"
    t.integer  "interrogatory_id"
  end

  add_index "documents", ["firm_id"], name: "index_documents_on_firm_id", using: :btree
  add_index "documents", ["interrogatory_id"], name: "index_documents_on_interrogatory_id", using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "event_attendees", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "display_name"
    t.boolean  "creator"
    t.string   "response_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
    t.integer  "firm_id"
  end

  add_index "event_attendees", ["contact_id"], name: "index_event_attendees_on_contact_id", using: :btree
  add_index "event_attendees", ["event_id"], name: "index_event_attendees_on_event_id", using: :btree

  create_table "event_participants", force: :cascade do |t|
    t.string  "status"
    t.integer "event_id"
    t.integer "participant_id"
    t.integer "firm_id"
  end

  add_index "event_participants", ["firm_id"], name: "index_event_participants_on_firm_id", using: :btree

  create_table "event_series", force: :cascade do |t|
    t.integer  "frequency",        default: 1
    t.string   "period",           default: "monthly"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "recur_start_date"
    t.datetime "recur_end_date"
    t.string   "when_type"
    t.boolean  "all_day",          default: false
    t.integer  "user_id"
    t.integer  "firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_series", ["firm_id"], name: "index_event_series_on_firm_id", using: :btree
  add_index "event_series", ["frequency"], name: "index_event_series_on_frequency", using: :btree
  add_index "event_series", ["user_id"], name: "index_event_series_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "nylas_event_id"
    t.string   "nylas_calendar_id"
    t.string   "nylas_namespace_id"
    t.text     "description"
    t.string   "location"
    t.boolean  "read_only"
    t.string   "title"
    t.boolean  "busy"
    t.string   "status"
    t.integer  "namespace_id"
    t.integer  "calendar_id"
    t.integer  "created_by"
    t.integer  "task_id"
    t.integer  "firm_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "when_type"
    t.boolean  "recur",              default: false
    t.integer  "event_series_id"
    t.boolean  "all_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_updated_by"
    t.integer  "owner_id"
    t.integer  "case_id"
    t.boolean  "is_reminder",        default: false
    t.integer  "lead_id"
  end

  add_index "events", ["case_id"], name: "index_events_on_case_id", using: :btree
  add_index "events", ["firm_id"], name: "index_events_on_firm_id", using: :btree
  add_index "events", ["lead_id"], name: "index_events_on_lead_id", using: :btree
  add_index "events", ["nylas_event_id"], name: "index_events_on_nylas_event_id", using: :btree
  add_index "events", ["owner_id"], name: "index_events_on_owner_id", using: :btree

  create_table "expenses", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "created_date"
    t.string   "expense"
    t.string   "aba_billing_code"
    t.decimal  "amount"
    t.text     "description"
    t.integer  "case_id"
    t.integer  "firm_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "invoice_id"
  end

  add_index "expenses", ["firm_id"], name: "index_expenses_on_firm_id", using: :btree
  add_index "expenses", ["invoice_id"], name: "index_expenses_on_invoice_id", using: :btree
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id", using: :btree

  create_table "firms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.string   "fax",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zip",        limit: 255
    t.string   "tenant",     limit: 255
    t.string   "state"
    t.string   "city"
    t.string   "address_2"
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
    t.integer  "defendant_liability"
    t.boolean  "alcohol_involved",                                          default: false
    t.boolean  "weather_factor",                                            default: false
    t.decimal  "property_damage",                  precision: 10, scale: 2
    t.boolean  "airbag_deployed",                                           default: false
    t.string   "speed",                limit: 255
    t.boolean  "police_report",                                             default: false
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "firm_id"
    t.boolean  "towed",                                                     default: false
    t.boolean  "complaint_at_scene",                                        default: false
    t.decimal  "defendant_limits"
    t.decimal  "plaintiff_limits"
    t.decimal  "uim_limits"
    t.date     "injury_date"
    t.boolean  "notice"
    t.date     "discovery_date"
    t.date     "first_sold_date"
    t.boolean  "foreign_object"
    t.date     "final_treatment_date"
    t.integer  "user_id"
    t.string   "location"
    t.string   "police_report_number"
  end

  add_index "incidents", ["case_id"], name: "index_incidents_on_case_id", using: :btree
  add_index "incidents", ["firm_id"], name: "index_incidents_on_firm_id", using: :btree

  create_table "injuries", force: :cascade do |t|
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
    t.integer  "user_id"
    t.integer  "case_id"
  end

  add_index "injuries", ["case_id"], name: "index_injuries_on_case_id", using: :btree
  add_index "injuries", ["firm_id"], name: "index_injuries_on_firm_id", using: :btree
  add_index "injuries", ["injury_type"], name: "index_injuries_on_injury_type", using: :btree
  add_index "injuries", ["medical_id"], name: "index_injuries_on_medical_id", using: :btree
  add_index "injuries", ["region"], name: "index_injuries_on_region", using: :btree

  create_table "insurances", force: :cascade do |t|
    t.string   "insurance_type"
    t.string   "insurance_provider"
    t.decimal  "policy_limit"
    t.string   "claim_number"
    t.integer  "case_id"
    t.integer  "firm_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "parent_id"
    t.integer  "user_id"
    t.integer  "company_id"
    t.decimal  "amount_paid"
    t.integer  "adjustor_id"
    t.integer  "policy_holder_id"
  end

  add_index "insurances", ["adjustor_id"], name: "index_insurances_on_adjustor_id", using: :btree
  add_index "insurances", ["company_id"], name: "index_insurances_on_company_id", using: :btree
  add_index "insurances", ["firm_id"], name: "index_insurances_on_firm_id", using: :btree
  add_index "insurances", ["policy_holder_id"], name: "index_insurances_on_policy_holder_id", using: :btree

  create_table "interrogatories", force: :cascade do |t|
    t.text     "question"
    t.text     "response"
    t.integer  "firm_id"
    t.integer  "case_id"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.integer  "parent_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.date     "req_date"
    t.date     "rep_date"
    t.integer  "requester_id"
    t.integer  "responder_id"
  end

  add_index "interrogatories", ["case_id"], name: "index_interrogatories_on_case_id", using: :btree
  add_index "interrogatories", ["created_by_id"], name: "index_interrogatories_on_created_by_id", using: :btree
  add_index "interrogatories", ["firm_id"], name: "index_interrogatories_on_firm_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "contact_id"
    t.date     "due_date"
    t.integer  "number"
    t.decimal  "amount",      default: 0.0
    t.decimal  "balance",     default: 0.0
    t.decimal  "payment_sum", default: 0.0
    t.string   "status"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "firm_id"
    t.integer  "user_id"
  end

  add_index "invoices", ["firm_id"], name: "index_invoices_on_firm_id", using: :btree
  add_index "invoices", ["number"], name: "index_invoices_on_number", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

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
    t.string   "status",               default: "pending_review"
    t.datetime "appointment_date"
    t.text     "note"
    t.integer  "firm_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "prefix"
    t.integer  "contact_id"
    t.string   "phone_book"
    t.integer  "referring_contact_id"
    t.string   "address_2"
  end

  add_index "leads", ["attorney_id"], name: "index_leads_on_attorney_id", using: :btree
  add_index "leads", ["contact_id"], name: "index_leads_on_contact_id", using: :btree
  add_index "leads", ["firm_id"], name: "index_leads_on_firm_id", using: :btree
  add_index "leads", ["status"], name: "index_leads_on_status", using: :btree

  create_table "medical_bills", force: :cascade do |t|
    t.string   "provider"
    t.date     "date_of_service"
    t.decimal  "billed_amount"
    t.decimal  "paid_amount"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "company_id"
    t.integer  "medical_id"
    t.integer  "parent_id"
    t.integer  "firm_id"
    t.integer  "case_id"
    t.integer  "user_id"
    t.integer  "physician_id"
    t.decimal  "adjustments"
    t.string   "account_number"
    t.string   "services"
    t.date     "last_date_of_service"
  end

  add_index "medical_bills", ["case_id"], name: "index_medical_bills_on_case_id", using: :btree
  add_index "medical_bills", ["company_id"], name: "index_medical_bills_on_company_id", where: "(company_id <> NULL::integer)", using: :btree
  add_index "medical_bills", ["firm_id"], name: "index_medical_bills_on_firm_id", using: :btree
  add_index "medical_bills", ["medical_id"], name: "index_medical_bills_on_medical_id", using: :btree
  add_index "medical_bills", ["parent_id"], name: "index_medical_bills_on_parent_id", where: "(parent_id <> NULL::integer)", using: :btree

  create_table "medicals", force: :cascade do |t|
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
    t.date     "injury_date"
    t.date     "final_treatment_date"
    t.integer  "user_id"
    t.string   "scans_tests",                                         default: [],    array: true
  end

  add_index "medicals", ["case_id"], name: "index_medicals_on_case_id", using: :btree
  add_index "medicals", ["firm_id"], name: "index_medicals_on_firm_id", using: :btree

  create_table "namespaces", force: :cascade do |t|
    t.string   "namespace_id"
    t.string   "account_id"
    t.string   "email_address"
    t.string   "name"
    t.string   "provider"
    t.integer  "user_id"
    t.string   "inbox_token"
    t.string   "account_status"
    t.string   "cursor"
    t.integer  "sync_period"
    t.datetime "last_sync"
    t.integer  "firm_id"
    t.boolean  "enabled",        default: true
  end

  add_index "namespaces", ["account_status"], name: "index_namespaces_on_account_status", using: :btree
  add_index "namespaces", ["enabled"], name: "index_namespaces_on_enabled", using: :btree
  add_index "namespaces", ["firm_id"], name: "index_namespaces_on_firm_id", using: :btree
  add_index "namespaces", ["user_id"], name: "index_namespaces_on_user_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "case_id"
    t.integer  "user_id"
    t.string   "note_type",  limit: 255
    t.string   "author",     limit: 255
    t.integer  "firm_id"
    t.boolean  "case_alert"
  end

  add_index "notes", ["case_id"], name: "index_notes_on_case_id", using: :btree
  add_index "notes", ["firm_id"], name: "index_notes_on_firm_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "notes_users", force: :cascade do |t|
    t.integer  "note_id"
    t.integer  "user_id"
    t.boolean  "is_author",          default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "secondary_note_id"
    t.integer  "secondary_owner_id"
  end

  add_index "notes_users", ["secondary_note_id"], name: "index_notes_users_on_secondary_note_id", using: :btree
  add_index "notes_users", ["secondary_owner_id"], name: "index_notes_users_on_secondary_owner_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "content"
    t.integer  "notificable_id"
    t.string   "notificable_type"
    t.integer  "user_id"
    t.boolean  "is_read",          default: false
    t.string   "author"
    t.integer  "note_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "is_remove",        default: false
  end

  add_index "notifications", ["notificable_type", "notificable_id"], name: "index_notifications_on_notificable_type_and_notificable_id", using: :btree

  create_table "old_events", force: :cascade do |t|
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
    t.integer  "task_id"
  end

  add_index "old_events", ["firm_id"], name: "index_old_events_on_firm_id", using: :btree
  add_index "old_events", ["google_calendar_id"], name: "index_old_events_on_google_calendar_id", using: :btree
  add_index "old_events", ["google_id"], name: "index_old_events_on_google_id", using: :btree
  add_index "old_events", ["owner_id"], name: "index_old_events_on_owner_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.string  "email"
    t.string  "name"
    t.integer "firm_id"
  end

  add_index "participants", ["firm_id"], name: "index_participants_on_firm_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "firm_id"
    t.integer  "invoice_id"
    t.decimal  "amount",     default: 0.0
    t.date     "date"
    t.string   "comment"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "number",     default: 1
  end

  add_index "payments", ["number"], name: "index_payments_on_number", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "label"
    t.string   "number"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "firm_id"
    t.string   "extension"
  end

  add_index "phones", ["contact_id"], name: "index_phones_on_contact_id", using: :btree
  add_index "phones", ["firm_id"], name: "index_phones_on_firm_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.string   "price_description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

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
    t.integer  "user_id"
    t.decimal  "contingent_fee"
  end

  add_index "resolutions", ["case_id"], name: "index_resolutions_on_case_id", using: :btree
  add_index "resolutions", ["firm_id"], name: "index_resolutions_on_firm_id", using: :btree
  add_index "resolutions", ["resolution_type"], name: "index_resolutions_on_resolution_type", using: :btree

  create_table "settlements", force: :cascade do |t|
    t.integer  "firm_id"
    t.integer  "case_id"
    t.integer  "created_by_id"
    t.integer  "last_updated_by_id"
    t.integer  "template_id",        default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "settlements", ["case_id"], name: "index_settlements_on_case_id", using: :btree
  add_index "settlements", ["created_by_id"], name: "index_settlements_on_created_by_id", using: :btree
  add_index "settlements", ["firm_id"], name: "index_settlements_on_firm_id", using: :btree
  add_index "settlements", ["template_id"], name: "index_settlements_on_template_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "plan_id"
    t.string   "email"
    t.string   "stripe_customer_token"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "stripe_card_token"
    t.integer  "user_id"
    t.string   "last_digits"
  end

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

  add_index "task_drafts", ["parent_id"], name: "index_task_drafts_on_parent_id", using: :btree
  add_index "task_drafts", ["task_list_id"], name: "index_task_drafts_on_task_list_id", using: :btree

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

  add_index "task_lists", ["firm_id"], name: "index_task_lists_on_firm_id", using: :btree
  add_index "task_lists", ["user_id"], name: "index_task_lists_on_user_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.date     "due_date"
    t.date     "completed"
    t.boolean  "sms_reminder",                    default: false
    t.boolean  "email_reminder",                  default: false
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
    t.integer  "case_id"
    t.integer  "secondary_owner_id"
  end

  add_index "tasks", ["case_id"], name: "index_tasks_on_case_id", using: :btree
  add_index "tasks", ["firm_id"], name: "index_tasks_on_firm_id", using: :btree
  add_index "tasks", ["owner_id"], name: "index_tasks_on_owner_id", using: :btree
  add_index "tasks", ["secondary_owner_id"], name: "index_tasks_on_secondary_owner_id", using: :btree

  create_table "template_documents", force: :cascade do |t|
    t.text     "html_content"
    t.string   "name"
    t.integer  "template_id"
    t.integer  "firm_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "template_documents", ["firm_id"], name: "index_template_documents_on_firm_id", using: :btree
  add_index "template_documents", ["user_id"], name: "index_template_documents_on_user_id", using: :btree

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

  add_index "templates", ["firm_id"], name: "index_templates_on_firm_id", using: :btree
  add_index "templates", ["user_id"], name: "index_templates_on_user_id", using: :btree

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
    t.string   "activity"
    t.integer  "invoice_id"
  end

  add_index "time_entries", ["case_id"], name: "index_time_entries_on_case_id", using: :btree
  add_index "time_entries", ["invoice_id"], name: "index_time_entries_on_invoice_id", using: :btree
  add_index "time_entries", ["user_id"], name: "index_time_entries_on_user_id", using: :btree

  create_table "user_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_events", ["event_id"], name: "index_user_events_on_event_id", using: :btree
  add_index "user_events", ["user_id"], name: "index_user_events_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.integer  "hourly_rate"
    t.string   "middle_name"
    t.string   "events_color"
    t.boolean  "edit_events_permit",                 default: false
    t.boolean  "disabled",                           default: false
    t.integer  "confirm_step",                       default: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["firm_id"], name: "index_users_on_firm_id", using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
