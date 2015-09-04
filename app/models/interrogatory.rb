class Interrogatory < ActiveRecord::Base
	before_create :save_firm_case_user_for_child
	after_save :update_document

	has_one :document, class_name: 'Document', foreign_key: 'interrogatory_id', :dependent => :destroy
	belongs_to :firm
	belongs_to :case
	belongs_to :user, class_name: 'User', foreign_key: 'created_by_id'
	belongs_to :requester, class_name: 'Contact', foreign_key: 'requester_id'
	belongs_to :responder, class_name: 'Contact', foreign_key: 'responder_id'

	has_many :children, class_name: "Interrogatory", foreign_key: "parent_id", :dependent => :destroy
	belongs_to :parent, class_name: "Interrogatory"

	accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => :true
	accepts_nested_attributes_for :document, :reject_if => :all_blank, :allow_destroy => :true, :reject_if => :document_invalid


	def save_firm_case_user_for_child
		if self.parent_id
			self.case = parent.case
			self.firm = parent.firm
			self.user = parent.user
		end
	end

	def update_document
		if document
			document.doc_type = "Interrogatory: " + try(:question)
			document.cases << self.case unless CaseDocument.where(case_id: case_id, document_id: document.id).exists?
			document.save
		end
	end

private
	def clean_s3
		document.remove!
		#document.thumb.remove! # if you have thumb version or any other version
		rescue Excon::Errors::Error => error
		puts "Something has gone wrong"
		false
	end

	def document_invalid(attributes)
		attributes['document'] == nil
	end
end
