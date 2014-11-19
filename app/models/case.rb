class Case < ActiveRecord::Base

  TYPES = ['Personal Injury', 'Bankruptcy', 'Criminal', 'Contract', 'Domestic', 'Immigration', 'Real Estate', 'Wills', 'Trusts', 'Estates']
  SUB_TYPES = ['Motor Vehicle', 'Medical Malpractice', 'Negligence', 'Class Action', 'Workers Compensation']
  STATUS = ['open', 'pending', 'closed']

  #enum status: { open: 0, pending: 1, closed: 2 }

  has_one :incident, dependent: :destroy
  has_one :medical, dependent: :destroy
  has_one :resolution, dependent: :destroy

  belongs_to :user
  belongs_to :firm

  has_many :case_contacts, :dependent => :destroy
  has_many :contacts, :through => :case_contacts

  has_many :case_documents, :dependent => :destroy
  has_many :documents, :through => :case_documents

  has_many :case_tasks, :dependent => :destroy
  has_many :tasks, :through => :case_tasks

  has_many :case_events, :dependent => :destroy
  has_many :events, :through => :case_events
  
  has_many :notes

  # searchable do
  #   text :state
  #   text :court
  #   text :injury_type do
  #     medical.injuries.map { |injury| injury.injury_type } if medical
  #   end
  #   text :region do
  #     medical.injuries.map { |injury| injury.region } if medical
  #   end
  #   text :insurer do
  #     incident.insurance_provider if incident
  #   end
  # end

  accepts_nested_attributes_for :documents
  accepts_nested_attributes_for :medical, :allow_destroy => true
  accepts_nested_attributes_for :incident, :allow_destroy => true
  accepts_nested_attributes_for :resolution, :allow_destroy => true

  validates :name, presence: true
  validates :case_number, presence: true
  validates :case_type, presence: true
  validates :subtype, presence: true
  validates :state, length: { is: 2 }, allow_blank: true
  #validates :closing_date, presence: true , if: "self.closed?"
  #validates :closing_date, absence: true, if: "self.pending? || self.open?"

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.increment_number(firm_, action_, case_)
    puts "ACTION NAME " + action_ 
    if action_ != "edit"
      puts " MAX NUM: " + firm_.cases.maximum(:case_number).to_s
      new_number = firm_.cases.maximum(:case_number).to_i + 1
      puts "INCREMENT NUMBER FIRM: " + firm_.to_s + "   and NUMBER: " + new_number.to_s
      new_number.to_i
    else
      case_.case_number
    end
  end

end
