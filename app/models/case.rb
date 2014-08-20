class Case < ActiveRecord::Base

	has_one :attorney, :through => :contact
	has_one :client, :through => :contact
  has_one :incident, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :documents
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :events
  has_many :notes

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
