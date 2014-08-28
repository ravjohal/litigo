class Case < ActiveRecord::Base

  has_many :contacts
	has_many :assigned_attorneys, :through => :contacts, source: :contactable, source_type: 'Attorney'
	has_many :assigned_clients, :through => :contacts, source: :contactable, source_type: 'Client'
  has_many :assigned_defendants, :through => :contacts, source: :contactable, source_type: 'Defendant'
  has_many :assigned_plantiffs, :through => :contacts, source: :contactable, source_type: 'Plantiff'
  has_many :assigned_staffs, :through => :contacts, source: :contactable, source_type: 'Staff'
  
  #has_many :attorneys, :through => :contacts
  #has_many :clients, :through => :contacts
  #has_many :defendants, :through => :contacts
  #has_many :plantiffs, :through => :contacts
  #has_many :staffs, :through => :contacts

  has_one :incident, dependent: :destroy

  belongs_to :user
  belongs_to :firm
  has_and_belongs_to_many :documents
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :events
  has_many :notes

	validates :number, :presence => true
	validates :case_type, :presence => true
	validates :subtype, :presence => true

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
