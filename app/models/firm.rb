class Firm < ActiveRecord::Base
	has_many :users
	has_many :cases
	has_many :contacts
	has_many :documents
	has_many :templates
  has_many :template_documents
	has_many :events
	has_many :incidents
	has_many :medicals
	has_many :injuries
	has_many :notes
	has_many :tasks
	has_many :resolutions
	has_many :google_calendars
	has_many :leads
	has_many :task_lists
	has_many :time_entries, :through => :users
	has_many :medical_bills
	has_many :companies
  has_many :expenses

	validates_presence_of :name
	validates_uniqueness_of :name

  accepts_nested_attributes_for :users



  def more_than_one_admin
    self.users.where(:role => 1).size > 1
  end

  def attorneys
    self.users.where(role: 2)
  end

  def admin_n_attorneys
    self.users.where.not(role: 0)
  end
end
