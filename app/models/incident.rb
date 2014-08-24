class Incident < ActiveRecord::Base
  belongs_to :case

  validates :liability, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  has_attached_file :police_report, default_url: ''
  validates_attachment_size :police_report, less_than: 10.megabytes
  validates_attachment_content_type :police_report,
                                    content_type: [ 'application/pdf' ],
                                    message: 'only pdf files are allowed'
end
