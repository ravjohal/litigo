class Document < ActiveRecord::Base
	belongs_to :user
	belongs_to :firm
	
	has_many :case_documents, :dependent => :destroy
	has_many :cases, :through => :case_documents

	mount_uploader :document, DocumentUploader

	before_destroy :clean_s3

	private
	  def clean_s3
	    document.remove!
	    #document.thumb.remove! # if you have thumb version or any other version
	  rescue Excon::Errors::Error => error
	    puts "Something gone wrong"
	    false
	  end
end
