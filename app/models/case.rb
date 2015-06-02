class Case < ActiveRecord::Base

  TYPES = ['Personal Injury', 'Wrongful Death', 'Bankruptcy', 'Criminal', 'Contract', 'Domestic', 'Immigration', 'Real Estate', 'Wills', 'Trusts', 'Estates']
  SUB_TYPES = ['Motor Vehicle', 'Medical Malpractice', 'Dog Bite', 'Product Liability', 'Slip and Fall', 'Premise Liability', 'Insurance Bad Faith', 'Intentional Tort', 'Workers Compensation']
  # STATUS = ['Open', 'Pending', 'Closed']
  STATUS = ['Active', 'Done Treating', 'Settlement Package Out', 'Negotiation', 'Litigation', 'Pending Close', 'Closed', 'Appeal']

  #enum status: { open: 0, pending: 1, closed: 2 }

  has_one :incident, dependent: :destroy
  has_one :insurance, dependent: :destroy
  has_one :medical, dependent: :destroy
  has_one :resolution, dependent: :destroy

  belongs_to :user
  belongs_to :firm

  has_many :case_contacts, :dependent => :destroy
  has_many :contacts, :through => :case_contacts

  has_many :case_contacts, :dependent => :destroy
  has_many :plaintiffs, :through => :case_contacts

  has_many :case_documents, :dependent => :destroy
  has_many :documents, :through => :case_documents

  # has_many :case_tasks, :dependent => :destroy
  # has_many :tasks, :through => :case_tasks
  has_many :tasks
  has_many :case_events, :dependent => :destroy
  has_many :events, :through => :case_events
  belongs_to :lead
  has_many :notes
  has_many :time_entries
  has_many :expenses

  include PgSearch
  pg_search_scope :search_case, against: [:name, :case_number, :case_type, :description, :status],
                  using: {tsearch: {dictionary: "english", prefix: true}},
                  associated_against: { :medical => :total_med_bills }
  attr_accessor :current_user_id, :attorney, :adjuster, :plaintiff, :defendant,
                :staff, :judge, :witness, :expert, :physician, :general, :company
  after_create :import_tasks
  before_save :set_tasks_due_dates
  before_save :capture_transfer_date

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
  # accepts_nested_attributes_for :incident, :allow_destroy => true
  accepts_nested_attributes_for :insurance, :allow_destroy => true
  accepts_nested_attributes_for :resolution, :allow_destroy => true

  validates :name, presence: true
  # validates :case_number, presence: true
  validates :case_type, presence: true
  # validates :subtype, presence: true
  validates :state, length: { is: 2 }, allow_blank: true
  #validates :closing_date, presence: true , if: "self.closed?"
  #validates :closing_date, absence: true, if: "self.pending? || self.open?"

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
    self.lead.created_at.strftime("%b %e, %Y") if self.lead
  end

  def primary_injury
    self.medical.injuries.where(primary_injury: true).try(:first) if self.medical.present? && self.medical.injuries.present?
  end

  # def plaintiff
  #   self.plaintiffs.find_by(type: 'Plaintiff')
  # end


  def calculate_sol(model, options=nil)
    if state == 'OH'
      if model.class.name == 'CaseContact' && model.role == 'Plaintiff'
        if case_type == 'Wrongful Death'
          if options[:date_of_death_changed]
            self.update(statute_of_limitations: model.contact.date_of_death + 2.years, sol_priority: 1) if statute_of_limitations.blank? || (model.contact.date_of_death + 2.years > statute_of_limitations && (sol_priority.blank? || sol_priority >= 1))
          end
        elsif case_type == 'Personal Injury'
          if options[:major_date_changed] && model.contact.minor
            self.update(statute_of_limitations: model.contact.major_date + 2.years, sol_priority: 2) if statute_of_limitations.blank? || (model.contact.major_date + 2.years > statute_of_limitations && (sol_priority.blank? || sol_priority >= 2))
          end
        end
      elsif model.class.name == 'Incident'
        if case_type == 'Personal Injury'
          if subtype == 'Medical Malpractice'
            self.update(statute_of_limitations: model.incident_date + 1.years, sol_priority: 3) if statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 3)
          elsif subtype == 'Intentional Tort'
            self.update(statute_of_limitations: model.incident_date + 1.years, sol_priority: 4) if statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 4)
          elsif subtype == 'Insurance Bad Faith'
            self.update(statute_of_limitations: model.incident_date + 4.years, sol_priority: 5) if statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 5)
          else
            self.update(statute_of_limitations: model.incident_date + 2.years, sol_priority: 6) if statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 6)
          end
        end
      end
    end
  end


  # def calculate_sol(model, options=nil)
  #   if state == 'OH'
  #     if model.class.name == 'CaseContact' && model.role == 'Plaintiff'
  #       if options[:date_of_death_changed] && case_type == 'Wrongful Death'
  #         self.update(statute_of_limitations: model.contact.date_of_death + 2.years, sol_priority: 1) if statute_of_limitations.blank? || (model.contact.date_of_death + 2.years > statute_of_limitations && (sol_priority.blank? || sol_priority >= 1))
  #       elsif options[:major_date_changed] && model.contact.minor
  #         self.update(statute_of_limitations: model.contact.major_date + 2.years, sol_priority: 2) if statute_of_limitations.blank? || (model.contact.major_date + 2.years > statute_of_limitations && (sol_priority.blank? || sol_priority >= 2))
  #       end
  #     elsif model.class.name == 'Incident'
  #       if subtype == 'Medical Malpractice'
  #         self.update(statute_of_limitations: model.incident_date + 1.years, sol_priority: 3) if statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 3)
  #       elsif subtype == 'Intentional Tort'
  #         self.update(statute_of_limitations: model.incident_date + 1.years, sol_priority: 4) if statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 4)
  #       elsif subtype == 'Insurance Bad Faith'
  #         self.update(statute_of_limitations: model.incident_date + 4.years, sol_priority: 5) if statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 5)
  #       end
  #       if case_type == 'Personal Injury'
  #         self.update(statute_of_limitations: model.incident_date + 2.years, sol_priority: 6) if statute_of_limitations.blank? || (sol_priority.blank? || sol_priority >= 6)
  #       end
  #     end
  #   end
  # end

  def check_sol
    if state == 'OH'
      if sol_priority != 0
        plaintiffs_contacts = self.case_contacts.where(role: 'Plaintiff').collect {|cc| cc.contact}
        self.assign_attributes(statute_of_limitations: nil, sol_priority: nil)
        if case_type == 'Personal Injury'
          if subtype == 'Medical Malpractice'
            self.assign_attributes(statute_of_limitations: incident.incident_date + 1.years, sol_priority: 3) if incident.present? && incident.incident_date.present?
          elsif subtype == 'Intentional Tort'
            self.assign_attributes(statute_of_limitations: incident.incident_date + 1.years, sol_priority: 4) if incident.present? && incident.incident_date.present?
          elsif subtype == 'Insurance Bad Faith'
            self.assign_attributes(statute_of_limitations: incident.incident_date + 4.years, sol_priority: 5) if incident.present? && incident.incident_date.present?
          elsif plaintiffs_contacts.present?
            plaintiffs_contacts.each do |plaintiff|
              if plaintiff.major_date.present? && plaintiff.minor
                self.assign_attributes(statute_of_limitations: plaintiff.major_date + 2.years, sol_priority: 2) if statute_of_limitations.blank? || (sol_priority == 2 && plaintiff.major_date + 2.years < statute_of_limitations ) || (plaintiff.major_date + 2.years > statute_of_limitations && (sol_priority.blank? || sol_priority >= 2))
              end
            end
          else
            self.assign_attributes(statute_of_limitations: self.incident.incident_date + 2.years, sol_priority: 6) if self.incident.present? && self.incident.incident_date.present? && (sol_priority.blank? || sol_priority >= 6)
          end
        elsif case_type == 'Wrongful Death'
          if plaintiffs_contacts.present?
            self.assign_attributes(statute_of_limitations: nil, sol_priority: nil)
            plaintiffs_contacts.each do |plaintiff|
              if plaintiff.date_of_death.present?
                self.assign_attributes(statute_of_limitations: plaintiff.date_of_death + 2.years, sol_priority: 1) if statute_of_limitations.blank? || (sol_priority == 1 && plaintiff.date_of_death + 2.years < statute_of_limitations ) || (plaintiff.date_of_death + 2.years > statute_of_limitations && (sol_priority.blank? || sol_priority >= 1))
              end
            end
          end
        end
        self.save
      end
    end
  end

  # def check_sol
  #   if state == 'OH'
  #     if sol_priority != 0
  #       self.assign_attributes(statute_of_limitations: nil, sol_priority: nil)
  #       if subtype == 'Medical Malpractice'
  #         self.assign_attributes(statute_of_limitations: incident.incident_date + 1.years, sol_priority: 3) if incident.present? && incident.incident_date.present?
  #       elsif subtype == 'Intentional Tort'
  #         self.assign_attributes(statute_of_limitations: incident.incident_date + 1.years, sol_priority: 4) if incident.present? && incident.incident_date.present?
  #       elsif subtype == 'Insurance Bad Faith'
  #         self.assign_attributes(statute_of_limitations: incident.incident_date + 4.years, sol_priority: 5) if incident.present? && incident.incident_date.present?
  #       end
  #       if case_type == 'Wrongful Death'
  #         plaintiffs_contacts = self.case_contacts.where(role: 'Plaintiff').collect {|cc| cc.contact}
  #         if plaintiffs_contacts.present?
  #           self.assign_attributes(statute_of_limitations: nil, sol_priority: nil)
  #           plaintiffs_contacts.each do |plaintiff|
  #             if plaintiff.date_of_death.present?
  #               self.assign_attributes(statute_of_limitations: plaintiff.date_of_death + 2.years, sol_priority: 1) if statute_of_limitations.blank? || (sol_priority == 1 && plaintiff.date_of_death + 2.years < statute_of_limitations ) || (plaintiff.date_of_death + 2.years > statute_of_limitations && (sol_priority.blank? || sol_priority >= 1))
  #             elsif plaintiff.major_date.present? && plaintiff.minor
  #               self.assign_attributes(statute_of_limitations: plaintiff.major_date + 2.years, sol_priority: 2) if statute_of_limitations.blank? || (sol_priority == 2 && plaintiff.major_date + 2.years < statute_of_limitations ) || (plaintiff.major_date + 2.years > statute_of_limitations && (sol_priority.blank? || sol_priority >= 2))
  #             end
  #           end
  #         end
  #       elsif case_type == 'Personal Injury'
  #         self.assign_attributes(statute_of_limitations: self.incident.incident_date + 2.years, sol_priority: 6) if self.incident.present? && self.incident.incident_date.present? && (sol_priority.blank? || sol_priority >= 6)
  #       end
  #       # if statute_of_limitations_changed?
  #       #   self.recalculate_sol_tasks(self.statute_of_limitations)
  #       # end
  #       self.save
  #     end
  #   end
  # end

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
      elsif ['Active', 'Discovery', 'Negotiation'].include?(status)
        self.transfer_date = nil
      end
    end
  end

  def select_contact_role(role)
    self.case_contacts.where(role: role.capitalize).collect { |case_contact| case_contact.contact }
  end

  def assign_case_contacts(attrs)
    case_contacts = self.case_contacts #grab the existing case_contacts that are associated with the case
    #p "CASE CONTACTS ATTRS -------------------------------------------------------> " + attrs.inspect
    attrs.each do |k, v| #go thru each attrs hash that came from strong parameters
      c_contacts = case_contacts.where(role: k.titleize).to_a  unless k.contains("_note") #store all the case_contacts for each role type into variable
      #p "c_contacts = >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + c_contacts.inspect
      v.reject(&:empty?).each do |contact_id| #for each contact_id within case_contact
        #p "VALUE of CASE CONTACTS ===============================================================> " + contact_id.to_s
        if k
        CaseContact.find_or_create_by(case_id: self.id, firm_id: self.firm_id,  contact_id: contact_id, role: k.titleize) #update or create CaseContact
        c_contacts.delete(case_contacts.find_by(contact_id: contact_id, role: k.titleize))
      end
      c_contacts.each do |cc|
        cc.destroy
      end
    end
    check_sol
    return true
  end
end
