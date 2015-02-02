class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.integer :screener_id
      t.date :call_date
      t.integer :attorney_id
      t.string :first_name
      t.string :last_name
      t.string :marketing_channel
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :email
      t.string :phone
      t.date :dob
      t.string :ssn
      t.boolean :decreased
      t.string :referred_by
      t.boolean :attorney_already
      t.string :attorney_name
      t.date :incident_date
      t.string :case_type
      t.string :sub_type
      t.string :primary_injury
      t.string :primary_region
      t.boolean :hospitalized
      t.boolean :police_report
      t.text :case_summary
      t.integer :estimated_value
      t.string :lead_insurance
      t.integer :lead_policy_limit
      t.string :other_insurance
      t.integer :other_policy_limit
      t.string :status
      t.date :appointment_date
      t.text :note
      t.integer  :firm_id
      t.integer  :case_id

      t.timestamps null: false
    end
  end
end
# Screener: string (current_user) ???
# Call_date: date (auto today's date) ???
# Attorney: string (firm attorneys) ???
# First_name: string (of injured party)
# Last_name: string (of injured party)
# marketing_channel: string
# Address: string
# City: string
# State: string
# Zipcode: integer, precision 0
# email: string
# phone: string
# DOB: date
# SSN: integer, encrypt
# Decreased: boolean Y/N
# Referred_by: string
# Attorney_already: boolean Y/N
# attorney_name: string
# Incident_date: date
# Case_type: string
# Sub_type: string
# Primary_injury: string
# primary_region: string
# hospitalized: boolean Y/N
# Police_report: boolean Y/N
# case_summary: string
# estimated_value: integer, precision 0
# lead_insurance: string
# lead_policy_limit: integer, precision 0
# other_insurance: string
# other_policy_limit: integer, precision 0
# status: string
# Appt_date: date ?appointment?
# Notes: string ???