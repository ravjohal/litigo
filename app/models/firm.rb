class Firm < ActiveRecord::Base
	has_many :cases
	has_many :users
	has_many :contacts
	has_many :assigned_attorneys, :through => :contacts, source: :contactable, source_type: 'Attorney'
	has_many :assigned_clients, :through => :contacts, source: :contactable, source_type: 'Client'
    has_many :assigned_defendants, :through => :contacts, source: :contactable, source_type: 'Defendant'
    has_many :assigned_plantiffs, :through => :contacts, source: :contactable, source_type: 'Plantiff'
    has_many :assigned_staffs, :through => :contacts, source: :contactable, source_type: 'Staff'
    has_many :assigned_witnesses, :through => :contacts, source: :contactable, source_type: 'Witness'
	has_many :documents
end
