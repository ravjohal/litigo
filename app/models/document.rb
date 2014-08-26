class Document < ActiveRecord::Base
	belongs_to :user
	belongs_to :firm
	has_and_belongs_to_many :cases
	mount_uploader :document, DocumentUploader
end
