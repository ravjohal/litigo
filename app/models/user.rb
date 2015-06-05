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
  has_many :tasks #this user created these tasks

  has_many :events

  has_many :owned_tasks, class_name: 'Task', foreign_key: 'owner_id' #this user owns these tasks
  has_many :owned_tasks_secondary, class_name: 'Task', foreign_key: 'secondary_owner_id' #this user owns these tasks
  has_many :contacts
  has_one :contact_user, class_name: 'Contact', :dependent => :destroy
  has_many :cases
  has_many :notes
  has_many :google_calendars
  has_many :leads, class_name: 'Lead', foreign_key: 'attorney_id'
  has_many :task_lists
  has_many :time_entries
  has_many :medicals
  has_many :incidents
  has_many :resolutions
  has_many :insurances
  has_many :injuries
  has_many :companies
  has_many :medical_bills
  has_many :expenses
  has_many :namespaces, :dependent => :destroy
  has_many :calendars, :through => :namespaces
  has_many :participants, :through => :events


  belongs_to :firm
  validates_presence_of :first_name, :last_name
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map { |m| m.name } }

  attr_reader :raw_invitation_token
  accepts_nested_attributes_for :firm

  COLORS = [ '#0266C8', '#F90101', '#F2B50F', '#00933B', '#9966FF', '#FF6666', '#7E989C', '#00CC99', '#000099', '#FFCC66', '#00B700', '#f200ff', '#ff9900']

  def name
    self.first_name.present? && self.last_name.present? ? "#{self.first_name} #{self.last_name}" : self.email
  end

  def initials
    fn = self.first_name.present? ? self.first_name[0].downcase : ''
    mn = self.middle_name.present? ? self.middle_name[0].downcase : ''
    ln = self.last_name.present? ? self.last_name[0].downcase : ''
    return fn+mn+ln
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

  def color(index)
    if index > COLORS.length-1
      COLORS[index - COLORS.length]
    else
      COLORS[index]
    end
  end

end
