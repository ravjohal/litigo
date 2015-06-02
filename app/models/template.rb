class Template < ActiveRecord::Base
  require 'zip'

  FIELDS_LIST = [
      {
          name: 'Lead Information',
          attrs: [
              {name: 'Prefix', attr: 'prefix', model: 'Custom'},
              {name: 'Lead Full Name', attr: 'name', model: 'Lead'},
              {name: 'Lead First Name', attr: 'first_name', model: 'Lead'},
              {name: 'Lead Last Name', attr: 'last_name', model: 'Lead'},
              {name: 'Lead Address', attr: 'address', model: 'Lead'},
              {name: 'Lead City', attr: 'city', model: 'Lead'},
              {name: 'Lead State', attr: 'state', model: 'Lead'},
              {name: 'Lead Zip Code', attr: 'zip_code', model: 'Lead'},
              {name: 'Date of Intake', attr: 'create_at', model: 'Lead'}
          ]
      },
      {
          name: 'Case Information',
          attrs: [
              {name: 'Case Number', attr: 'case_number', model: 'Case'},
              {name: 'Case Name', attr: 'name', model: 'Case'},
              {name: 'Case Open Date', attr: 'created_at', model: 'Case'},
              {name: 'Primary Injury', attr: 'primary_injury.injury_type', model: 'Case'},
              {name: 'Primary Region', attr: 'primary_injury.region', model: 'Case'},
              {name: 'Lost Earnings', attr: 'medical.earnings_lost', model: 'Case'},
              {name: 'Total Medical Bills', attr: 'medical_bills', model: 'Case'},
              {name: 'Policy Limits', attr: 'insurance.policy_limit', model: 'Case'},
              {name: 'Insurance Provider', attr: 'insurance.insurance_provider', model: 'Case'},
              {name: 'Suit Filed Date', attr: 'filed_suit_date', model: 'Case'},
              {name: 'Statute of Limitations', attr: 'statute_of_limitations', model: 'Case'},
              {name: 'Docket Number', attr: 'number', model: 'Case'},
              {name: 'Court', attr: 'court', model: 'Case'},
              {name: 'County', attr: 'county', model: 'Case'},
              {name: 'State', attr: 'state', model: 'Case'}
          ]
      },
      {
          name: 'Incident',
          attrs: [
              {name: 'Date of Incident', attr: 'incident.incident_date', model: 'Case'},
              {name: 'Date of injury', attr: 'incident.injury_date', model: 'Case'},
              {name: 'Property Damage ($)', attr: 'incident.property_damage', model:'Case'},
              {name: 'Police Report Number', attr: 'incident.police_report_number', model: 'Case'},
              {name: 'Location', attr: 'incident.location', model: 'Case'}
          ]
      },
      {
          name: 'Contacts',
          attrs: [
              {name: 'Prefix', attr: 'prefix', model: 'Custom'},
              {name: 'Contact Full Name', attr: 'name', model: 'Contact'},
              {name: 'Contact First Name', attr: 'first_name', model: 'Contact'},
              {name: 'Contact Last Name', attr: 'last_name', model: 'Contact'},
              {name: 'Contact Email', attr: 'email', model: 'Contact'},
              {name: 'Contact Phone', attr: 'phone', model: 'Contact'},
              {name: 'Contact Address', attr: 'address', model: 'Contact'},
              {name: 'Contact City', attr: 'city', model: 'Contact'},
              {name: 'Contact State', attr: 'state', model: 'Contact'},
              {name: 'Contact Zip Code', attr: 'zip_code', model: 'Contact'},
              {name: 'Company Name', attr: 'name', model: 'Company'},
              {name: 'Company Address', attr: 'address', model: 'Company'},
              {name: 'Company City', attr: 'city', model: 'Company'},
              {name: 'Company State', attr: 'state', model: 'Company'},
              {name: 'Company Zip Code', attr: 'zipcode', model: 'Company'}
          ]
      },
      {
          name: 'Addressee',
          attrs: [
              {name: 'Prefix', attr: 'prefix', model: 'Custom'},
              {name: 'Salutation', attr: 'salutation', model: 'Custom'},
              {name: 'Addressee Full Name', attr: 'name', model: 'Addressee'},
              {name: 'Addressee Firm Name', attr: 'first_name', model: 'Addressee'},
              {name: 'Addressee Last Name', attr: 'last_name', model: 'Addressee'},
              {name: 'Addressee Email', attr: 'email', model: 'Addressee'},
              {name: 'Addressee Phone', attr: 'phone', model: 'Addressee'},
              {name: 'Addressee Address', attr: 'address', model: 'Addressee'},
              {name: 'Addressee City', attr: 'city', model: 'Addressee'},
              {name: 'Addressee State', attr: 'state', model: 'Addressee'},
              {name: 'Addressee Zip Code', attr: 'zip_code', model: 'Addressee'},
              {name: 'Addressee Company Name', attr: 'company.name', model: 'Addressee'}
          ]
      },
      {
          name: 'Firm Information',
          attrs: [
              {name: 'Firm Contact Initials', attr: 'contact_initials', model: 'Firm'},
              {name: 'Firm Contact', attr: 'contacts_names', model: 'Firm'}, #TODO add contacts_names method to Firm model to collect all firm contacts names
              {name: 'Firm Phone Number', attr: 'phone', model: 'Firm'},
              {name: 'Firm Name', attr: 'name', model: 'Firm'},
              {name: 'Firm Address', attr: 'address', model: 'Firm'},
              {name: 'Firm City', attr: 'city', model: 'Firm'}, #TODO add city to firms table
              {name: 'Firm State', attr: 'state', model: 'Firm'},
              {name: 'Firm Zip Code', attr: 'zip', model: 'Firm'} #TODO rename zip to zip_code
          ]
      },
      {
          name: 'Dates',
          attrs: [
              {name: 'Date Today', attr: 'today', model: 'Date'},
              {name: 'Date Field', attr: 'input_date', model: 'Custom'},
              {name: 'Date of Intake', attr: 'create_at', model: 'Lead'},
              {name: 'Date of Incident', attr: 'incident.incident_date', model: 'Case'},
              {name: 'Statute of Limitations', attr: 'incident.statute_of_limitations', model: 'Case'},
              {name: 'Suit Filed Date', attr: 'filed_suit_date', model: 'Case'},
              {name: 'Hearing Date', attr: 'hearing_date', model: 'Case'},
              {name: 'Date of Final Treatment', attr: 'medical.final_treatment_date', model: 'Case'},
              {name: 'Case Open Date', attr: 'created_at', model: 'Case'},
              {name: 'Case Closed Date', attr: 'closing_date', model: 'Case'},
          ]
      },
  ]

  belongs_to :user
  belongs_to :firm
  has_many :template_documents
  mount_uploader :file, DocumentUploader

  before_destroy :clean_s3

  def valid_zip?
    zip = Zip::File.open(file.path)
    true
  rescue StandardError
    false
  ensure
    zip.close if zip
  end

  private
  def clean_s3
    file.remove!
  rescue Excon::Errors::Error => error
    puts "Something has gone wrong"
    false
  end
end
