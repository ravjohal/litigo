class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  USER_ROLES = [:staff, :admin, :attorney]
  enum role: USER_ROLES
  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_show_onboarding, :if => :new_record?

  has_many :documents
  has_many :templates
  has_many :template_documents
  has_many :tasks

  has_many :user_events, :dependent => :destroy
  has_many :events, :through => :user_events

  has_many :owned_events, class_name: 'Event', foreign_key: 'owner_id'
  has_many :owned_tasks, class_name: 'Task', foreign_key: 'owner_id'
  has_many :contacts
  has_one :contact_user, class_name: 'Contact', foreign_key: 'contact_user_id', :dependent => :destroy
  has_many :cases
  has_many :notes
  has_many :google_calendars
  has_many :leads, class_name: 'Lead', foreign_key: 'attorney_id'
  has_many :task_lists
  has_many :time_entries
  has_many :medical_bills
  belongs_to :firm
  validates_presence_of :first_name, :last_name
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map { |m| m.name } }

  attr_reader :raw_invitation_token
  accepts_nested_attributes_for :firm

  def name
    self.first_name.present? && self.last_name.present? ? "#{self.first_name} #{self.last_name}" : ""
  end

  def set_default_role
    self.role ||= :staff 
  end

  def set_show_onboarding
    self.show_onboarding = true
  end

  def to_label
    self.first_name.blank? || self.last_name.blank? ? self.email : "#{self.first_name} #{self.last_name}"
  end

  def is_admin?
    self.role == 'admin'
  end

  def is_attorney?
    self.role == 'attorney'
  end

  def is_staff?
    self.role == 'staff'
  end
end
