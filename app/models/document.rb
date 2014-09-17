class Document < ActiveRecord::Base
	belongs_to :user
	
	has_many :case_documents, :dependent => :destroy
	has_many :cases, :through => :case_documents

	mount_uploader :document, DocumentUploader
end
