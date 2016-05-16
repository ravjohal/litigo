class Case < ActiveRecord::Base

  TYPES = ['Bankruptcy', 'Business Entities', 'Civil Litigation', 'Criminal Defense', 'Employment', 'Estates', 'Family Law', 'Immigration', 'Personal Injury', 'Probate', 'Real Estate', 'Taxation', 'Traffic', 'Wrongful Death']
  # STATUS = ['Open', 'Pending', 'Closed']
  STATUS = ['Active', 'Treating', 'Done Treating','Inactive', 'Finals Requested', 'Settlement Package Out', 'Negotiation', 'Litigation', 'Pending Close', 'Closed', 'Appeal']

  #enum status: { open: 0, pending: 1, closed: 2 }

  has_one :incident, dependent: :destroy
  # has_one :insurance, -> { where(parent_id: nil) }, dependent: :destroy
  # has_one :interrogatory, -> { where(parent_id: nil) }, dependent: :destroy
  has_one :medical, dependent: :destroy
  has_one :resolution, dependent: :destroy

  belongs_to :user
  belongs_to :firm
  has_many :notifications, as: :notificable
  has_many :case_contacts, :dependent => :destroy
  has_many :contacts, :through => :case_contacts
  has_many :plaintiffs, :through => :case_contacts
  has_many :case_documents, :dependent => :destroy
  has_many :documents, :through => :case_documents
  # has_many :case_tasks, :dependent => :destroy
  # has_many :tasks, :through => :case_tasks
  has_many :tasks
  has_many :case_events, :dependent => :destroy
  has_many :events
  belongs_to :lead
  has_many :notes
  has_many :time_entries
  has_many :expenses
  has_many :insurances
  has_many :interrogatories
  has_many :invoices

  accepts_nested_attributes_for :case_contacts, reject_if: lambda { |attributes| attributes['contact_id'].blank? }, :allow_destroy => :true
  accepts_nested_attributes_for :insurances, :reject_if => :all_blank, :allow_destroy => :true
  accepts_nested_attributes_for :interrogatories, :reject_if => :all_blank, :allow_destroy => :true

  include PgSearch
  pg_search_scope :search_case, against: [:name, :case_number, :case_type, :description, :status],
                  using: {tsearch: {dictionary: "english", prefix: true}},
                  associated_against: { :medical => :total_med_bills }
  attr_accessor :current_user_id, :attorney, :adjuster, :plaintiff, :defendant,
                :staff, :judge, :witness, :expert, :physician, :general, :company, :note
  after_create :import_tasks
  before_save :set_tasks_due_dates
  before_save :capture_transfer_date

  include StatesHelper

  # searchable do
  #   text :state
  #   text :court
  #   text :injury_type do
  #     medical.injuries.map { |injury| injury.injury_type } if medical
  #   end
  #   text :region do
  #     medical.injuries.map { |injury| injury.region } if medical
  #   end
  #   text :insurer do
  #     incident.insurance_provider if incident
  #   end
  # end

  accepts_nested_attributes_for :documents
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :medical, :allow_destroy => true
  accepts_nested_attributes_for :incident, :allow_destroy => true
  #accepts_nested_attributes_for :insurance, :allow_destroy => true
  accepts_nested_attributes_for :resolution, :allow_destroy => true

  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false
  # validates :case_number, presence: true
  validates :case_type, presence: true
  # validates :subtype, presence: true
  validates :state, length: { is: 2 }, allow_blank: true
  #validates :closing_date, presence: true , if: "self.closed?"
  #validates :closing_date, absence: true, if: "self.pending? || self.open?"

  amoeba do
    enable
  end

  SUB_TYPES = {
      'Bankruptcy' => {
          'Bankruptcy (general)' => 'Bankruptcy (general)',
      },
      'Business Entities' => {
          'LLC, Corp or Partnership' => 'LLC, Corp or Partnership',
          'Trademark or Copywright' => 'Trademark or Copywright',
          'Patent' => 'Patent'
      },
      'Civil Litigation' => {
           'Civil Litigation (general)' => 'Civil Litigation (general)',
           'Business Litigation (general)' => 'Business Litigation (general)',
           'Contract Dispute' => 'Contract Dispute',
           'Construction Litigation' => 'Construction Litigation',
           'Consumer Litigation' => 'Consumer Litigation',
           'Product Defect' => 'Product Defect'
      },
      'Criminal Defense' => {
            'Misdemeanor'  => 'Misdemeanor',
            'Felony'  => 'Felony',
            'DUI'  => 'DUI',
            'Drug Possession'  => 'Drug Possession',
      },
      'Employment Law' => {
          'Employmee Discrimination' => 'Employmee Discrimination',
          'Employement Contract' => 'Employement Contract',
          'Sexual Harassment' => 'Sexual Harassment',
          'Wage and Hour Claims' => 'Wage and Hour Claims',
          'Wrongful Termination' => 'Wrongful Termination'
      },
      'Estates' => {
          'Power of Attorney' => 'Power of Attorney',
          'Wills' => 'Wills',
          'Revocable Trust' => 'Revocable Trust'
      },
      'Family Law' => {
          'Divorce' => 'Divorce',
          'Prenuptial Agreement' => 'Prenuptial Agreement',
          'Postnuptial Agreement' => 'Postnuptial Agreement',
      },
       'Personal Injury' => {
          'Dog Bite' => 'Dog Bite',
          'Insurance Bad Faith' => 'Insurance Bad Faith',
          'Intentional Tort' => 'Intentional Tort',
          'Medical Malpractice' => 'Medical Malpractice',
          'Motor Vehicle' => 'Motor Vehicle',
          'Product Liability' => 'Product Liability',
          'Premise Liability' => 'Premise Liability',
          'Slip and Fall' => 'Slip and Fall',
          'Workers Compensation' => 'Workers Compensation'
      },
       'Probate' => {
          'Probate (general)' => 'Probate (general)'
      },
       'Real Estate' => {
          'Landlord-tenant Dispute' => 'Landlord-tenant Dispute',
          'Boundaries or Easements' => 'Boundaries or Easements',
          'Commercial Lease' => 'Commercial Lease',
          'Residential Lease' => 'Residential Lease',
          'Non-disclosure/Fraud' => 'Non-disclosure/Fraud'
      },
       'Taxation' => {
          'Foreclosure' => 'Foreclosure',
      },
       'Traffic' => {
          'Traffic Violation' => 'Traffic Violation',
      },
       'Wrongful Death' => {
          'Wrongful Death' => 'Wrongful Death',
      },
  }

  def full_subtype_list
    SUB_TYPES.select { |k, v| v.key(self.sub_types) }.values[0].key(self.sub_types) if self.sub_types.present?
  end

  def state_name
    (us_states.find {|s| s[1] == state}).to_a[0]
  end

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.increment_number(firm_, action_, case_)
#    puts "ACTION NAME " + action_ 
    if action_ != "edit"
#      puts " MAX NUM: " + firm_.cases.maximum(:case_number).to_s
      new_number = firm_.cases.maximum(:case_number).to_i + 1
#      puts "INCREMENT NUMBER FIRM: " + firm_.to_s + "   and NUMBER: " + new_number.to_s
      new_number.to_i
    else
      case_.case_number
    end
  end

  def analytic_json
    {
      :Case_name => name.to_s,
      :Id => id,
      :Case_type => subtype.to_s,
      :Color => resolution.try(:settlement?) ? 'blue' : 'red',
      :Topic => topic.to_s,
      :Docket =>  "Case No. #{docket_number}",
      :Injury => (medical.injuries.flat_map{|injury| injury.injury_type.to_s.split('/') + [injury.region]}).join(' - ').to_s,
      :Total_amount => resolution.try(:resolution_amount),
      :Group => resolution.try(:settlement?) ? 'medium' : 'high',
      :State => state_name.to_s,
      :County => county.to_s,
      :Court => court.to_s,
      :Judge => judge.try(:name).to_s,
      'Case.summary' => description.to_s,
      'Injury.text' => medical.injury_summary.to_s,
      'Incident.date' => incident.try(:incident_date).to_s,
      :Start_month => created_at.strftime('%m'),
      :Start_day => created_at.strftime('%d'),
      :Start_year => created_at.strftime('%Y'),
      :Is_na => (resolution.blank? || resolution.resolution_amount.blank?) ? 1 : 0
    }
  end

  def set_tasks_due_dates
    attrs = TaskDraft::ANCHOR_DATE_HASH['affair'].keys & self.changed
    if attrs.present?
      attrs.each do |attr|
        self.tasks.where(anchor_date: "affair.#{attr}").each do |task|
          task.set_due_date!(self.try(attr))
        end
      end
    end
  end

  def import_tasks
    TaskList.where(case_type: self.case_type, firm_id: self.firm_id, task_import: 'automatic').each do |task_list|
      if task_list.case_creator == 'all_firm' || task_list.case_creator == 'owner' && task_list.user_id == self.current_user_id
        task_list.import_to_case!(self.id, self.current_user_id)
      end
    end
  end

  def date_of_intake
    lead.created_at if lead
  end

  def primary_injury
    self.medical.injuries.where(primary_injury: true).try(:first) if self.medical.present? && self.medical.injuries.present?
  end

  # def plaintiff
  #   self.plaintiffs.find_by(type: 'Plaintiff')
  # end

  def plantiff_contacts
    case_contacts.where(role: 'Plaintiff')
  end

  def attorney_contacts
    case_contacts.where(role: 'Attorney')
  end


  def calculate_sol(model, options=nil)
    if state == 'OH'
      if model.class.name == 'CaseContact' && model.role == 'Plaintiff'
        plaintiffs_contacts = plantiff_contacts.collect {|cc| cc.contact}
        if case_type == 'Wrongful Death'
          if options.present? && options[:date_of_death_changed]
            min_death_date = plaintiffs_contacts.map { |d| d.date_of_death }.min
            self.update(statute_of_limitations: min_death_date + 2.years, sol_priority: 1) if min_death_date.present? && (statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 1))
          end
        elsif case_type == 'Personal Injury'
          if options.present? && options[:major_date_changed] && model.contact.minor
            min_major_date = plaintiffs_contacts.map { |d| d.major_date }.min
            self.update(statute_of_limitations: min_major_date + 2.years, sol_priority: 2) if min_major_date.present? && (statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 2))
          end
        end
      elsif model.class.name == 'Incident'
        if case_type == 'Personal Injury'
          if subtype == 'Medical Malpractice'
            calculated_sol = model.incident_date + 1.years
            self.update(statute_of_limitations: model.incident_date + 1.years, sol_priority: 3) if statute_of_limitations.blank? || ((sol_priority.blank? || sol_priority >= 3) && (statute_of_limitations != calculated_sol))
          elsif subtype == 'Intentional Tort'
            calculated_sol = model.incident_date + 1.years
            self.update(statute_of_limitations: model.incident_date + 1.years, sol_priority: 4) if statute_of_limitations.blank? || ((sol_priority.blank? || sol_priority >= 4) && (statute_of_limitations != calculated_sol))
          elsif subtype == 'Insurance Bad Faith'
            calculated_sol = model.incident_date + 4.years
            self.update(statute_of_limitations: model.incident_date + 4.years, sol_priority: 5) if statute_of_limitations.blank? || ((sol_priority.blank? || sol_priority >= 5) && (statute_of_limitations != calculated_sol))
          else
            calculated_sol = model.incident_date + 2.years
            self.update(statute_of_limitations: calculated_sol, sol_priority: 6) if statute_of_limitations.blank? || ((sol_priority.blank? || sol_priority >= 6) && (statute_of_limitations != calculated_sol))
          end
        end
      end
    end
  end

  def check_sol
    if state == 'OH'
      if sol_priority != 0
        plaintiffs_contacts = plantiff_contacts.collect {|cc| cc.contact}
        self.assign_attributes(statute_of_limitations: nil, sol_priority: nil)
        if case_type == 'Personal Injury'
          if subtype == 'Medical Malpractice'
            self.assign_attributes(statute_of_limitations: incident.incident_date + 1.years, sol_priority: 3) if incident.present? && incident.incident_date.present?
          elsif subtype == 'Intentional Tort'
            self.assign_attributes(statute_of_limitations: incident.incident_date + 1.years, sol_priority: 4) if incident.present? && incident.incident_date.present?
          elsif subtype == 'Insurance Bad Faith'
            self.assign_attributes(statute_of_limitations: incident.incident_date + 4.years, sol_priority: 5) if incident.present? && incident.incident_date.present?
          else
            self.assign_attributes(statute_of_limitations: self.incident.incident_date + 2.years, sol_priority: 6) if self.incident.present? && self.incident.incident_date.present? && (sol_priority.blank? || sol_priority >= 6)
          end
        if plaintiffs_contacts.present?
          min_major_date = plaintiffs_contacts.map { |d| d.major_date }.min
          self.assign_attributes(statute_of_limitations: min_major_date + 2.years, sol_priority: 2) if min_major_date.present? && (statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 2))
        end
        elsif case_type == 'Wrongful Death'
          if plaintiffs_contacts.present?
            self.assign_attributes(statute_of_limitations: nil, sol_priority: nil)
            min_death_date = plaintiffs_contacts.map { |d| d.date_of_death }.min
            self.assign_attributes(statute_of_limitations: min_death_date + 2.years, sol_priority: 1) if min_death_date.present? && (statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 1))
          end
        end
        self.save
      end
    end
  end

  def recalculate_sol_tasks(sol)
    self.tasks.each do |task|
      if sol.present? && task.anchor_date == 'affair.statute_of_limitations'
        task.set_due_date!(sol)
      end
    end
  end

  def capture_transfer_date
    if self.status_changed?
      if status == 'Litigation'
        self.transfer_date = Date.today
      elsif %w(Active Discovery Negotiation).include?(status)
        self.transfer_date = nil
      end
    end
  end

  def select_contact_role(role)
    self.case_contacts.where(role: role.capitalize).collect { |case_contact| case_contact.contact }
  end

  def get_role_note(role)
    self.case_contacts.find_by_role(role.capitalize).note if self.case_contacts.find_by_role(role.capitalize)
  end

  def assign_case_contacts(attrs)
    case_contacts = self.case_contacts #grab the existing case_contacts that are associated with the case
    attrs.each do |key, value| # go thru each attrs hash that came from the controller
      # key is contact_type, example: attorney
      # value is hash, example: {"attorney"=>["", "1907"], "note"=>"a"}
      k, v = value.first # grab the first value of the hash, which are contact_ids with their role, example: "attorney"=>["", "1907"]
      #p " VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV ----- " + v.inspect
        # k is the role, example: attorney
        # v is the contact_ids value, example: ["", "1907"]
        c_contacts = case_contacts.where(role: k.titleize).to_a  #store all the case_contacts for each role type into array
          v.reject(&:empty?).each do |contact_id| #for each contact_id within case_contact
           # p " CONTACT ID   ------->>>>>>>>>>>>>>>>>>>>>>>>> " + contact_id.to_s +  "  note: " + value[:note].to_s
            case_contact = CaseContact.find_or_create_by(case_id: self.id, firm_id: self.firm_id,  contact_id: contact_id, role: k.titleize) #update or create CaseContact
            case_contact.update_attributes(:note => value[:note]) # update what was created or found with the latest note
            c_contacts.delete(case_contacts.find_by(contact_id: contact_id, role: k.titleize)) # update array that contains all the existing case_contacts to take out the ones that weren't deleted
          end
        c_contacts.each do |cc| #delete all case_contacts from db that weren't updated, but rather deleted by user
          cc.destroy
        end
    end
    check_sol
    true
  end

  def assign_case_attorney_staff(attrs) #this method is called on create of case, where note is not needed
    case_contacts = self.case_contacts
    attrs.each do |k, v|
      c_contacts = case_contacts.where(role: k.titleize).to_a
      v.reject(&:empty?).each do |contact_id|
        CaseContact.find_or_create_by(case_id: self.id, firm_id: self.firm_id, contact_id: contact_id, role: k.titleize)
        c_contacts.delete(case_contacts.find_by(contact_id: contact_id, role: k.titleize))
      end
      c_contacts.each do |cc|
        cc.destroy
      end
    end
    check_sol
    true
  end

  def self.open_cases_scope
    where.not(['status = ? or status = ?', 'Inactive', 'Closed'])
  end

  def self.closed_cases_scope
    where(:status => %w(Inactive Closed))
  end

end