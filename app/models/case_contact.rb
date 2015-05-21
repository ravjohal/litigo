class CaseContact < ActiveRecord::Base
	belongs_to :affair, class_name: 'Case', :foreign_key => 'case_id'
	belongs_to :contact
	# belongs_to :plaintiff, :foreign_key => :contact_id
end
