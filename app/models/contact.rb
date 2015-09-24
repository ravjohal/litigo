class Contact < ActiveRecord::Base
  attr_encrypted :ssn, :key => 'zU8CYfjkHEQbghnwQzXeJA=='

  ATTORNEYS = ['Plaintiff', 'Defense', 'General Counsel', 'Co-counsel', 'Outside Counsel', 'Prosecution']

  TYPES = ['Attorney', 'Staff', 'Plaintiff', 'Defendant', 'Judge', 'Witness', 'Expert', 'Physician', 'Adjuster', 'General', 'Company']

  has_many :event_attendees
	belongs_to :user #user that owns this contact, basically the one who created this contact, answers: who created this contact?
  belongs_to :event
  belongs_to :user_account, class_name: 'User', foreign_key: 'user_account_id' #associated contact of the user, answers: is this contact a user?
  belongs_to :firm
  belongs_to :company
  belongs_to :lead
  has_one :referred_lead, class_name: 'Lead'
  has_many :case_contacts, :dependent => :destroy
  has_and_belongs_to_many :cases, :join_table => 'case_contacts'
  has_many :phones
  has_many :requesters, class_name: 'Interrogatory', foreign_key: 'requester_id'
  has_many :responders, class_name: 'Interrogatory', foreign_key: 'responder_id'

  amoeba do
    enable
    propagate
  end

  accepts_nested_attributes_for :phones, :reject_if => :all_blank, :allow_destroy => :true

  after_save :check_sol
  before_save :check_sol
  # validates :phone_number, length: { maximum: 10 }
  # validates :fax_number, length: { maximum: 10 }

  after_save :load_into_soulmate

  def load_into_soulmate
    return if email.blank?
    loader = Soulmate::Loader.new("contact-#{firm_id}")
    loader.add('term' => email, 'id' => "contact-#{id}")
  end

  def self.inherited(child)
    child.instance_eval do
      def model_name
        Contact.model_name
      end
    end
    super
  end

  def name
    if self.type == "Company"
 #     puts "ARE WE IN COMPANY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "
      self.company_name
    else
      if self.first_name.blank? && self.last_name.blank?
        self.email
      else
        "#{self.first_name.present? ? self.first_name : ''} #{self.last_name.present? ? self.last_name : ''}"
      end
    end
  end

  def shift_name
    if self.type == "Company"
      #     puts "ARE WE IN COMPANY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "
      self.company_name
    else
      if self.first_name.blank? && self.last_name.blank?
        self.email
      else
        "#{self.last_name.present? ? self.last_name : ''} #{self.first_name.present? ? self.first_name : ''}"
      end
    end
  end

  def tooltip
    if self.phone_number.present? || self.mobile.present? || self.email.present?
      p = self.phone_number.present? ? "P: #{self.phone_number}<br/>" : ''
      m = self.mobile.present? ? "M: #{self.mobile}<br/>" : ''
      e = self.email.present? ? "#{self.email}" : ''
      return p+m+e
    end
  end

  def check_sol
    if date_of_death_changed? || major_date_changed?
      self.case_contacts.each do |cc|
        if cc.role == 'Plaintiff'
          options = {date_of_death_changed: date_of_death_changed?, major_date_changed: major_date_changed?}
          cc.affair.calculate_sol(cc, options)
        end
      end
    end
  end

  def name_with_company
    if self.first_name.present? || self.company_name.present?
      name = self.first_name.present? ? "#{self.first_name} #{self.last_name}" : ''
      company = self.company_name.present? ? "#{self.company_name}" : ''
      return "#{name}"+"#{company}"
    end
  end

  def similar_scope
    Contact.where(firm_id: firm_id).where('lower(last_name) = ?', last_name.to_s.downcase).includes(:cases)
  end

  def similar_contacts
    similar_scope.where.not(id: id)
  end

  def similar_contact?
    new_record? ?
        similar_scope.any? :
        similar_contacts.any?
  end

end
