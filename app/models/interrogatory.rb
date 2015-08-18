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
	accepts_nested_attributes_for :document, :reject_if => :all_blank, :allow_destroy => :true


	def save_firm_case_user_for_child
		if self.parent_id
			self.case = self.parent.case
			self.firm = self.parent.firm
			self.user = self.parent.user
		end
	end

	def update_document
		if self.document
			self.document.doc_type = "Interrogatory: " + self.try(:question)
			self.document.cases << self.case
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
end
