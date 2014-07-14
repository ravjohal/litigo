class Case < ActiveRecord::Base

	has_one :attorney, :through => :contact
	has_one :client, :through => :contact
  has_many :documents
  has_many :tasks
  has_many :events

	validates :number, :presence => true
	validates :case_type, :presence => true
	validates :subtype, :presence => true

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
