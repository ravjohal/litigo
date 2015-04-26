class CaseContact < ActiveRecord::Base
	belongs_to :case
	belongs_to :contact
	belongs_to :plaintiff, :foreign_key => :contact_id
end
