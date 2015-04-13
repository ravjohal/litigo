class Template < ActiveRecord::Base
  belongs_to :user
  belongs_to :firm

  mount_uploader :file, DocumentUploader

  before_destroy :clean_s3

  private
  def clean_s3
    file.remove!
  rescue Excon::Errors::Error => error
    puts "Something has gone wrong"
    false
  end
end
