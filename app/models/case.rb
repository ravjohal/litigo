class Case < ActiveRecord::Base

  TYPES = ['Personal injury']
  SUB_TYPES = ['Motor Vehicle', 'Medical Malpractice', 'Negligence', 'Class Action']

  enum status: { open: 0, pending: 1, closed: 2 }

  has_many :contacts

  has_one :incident, dependent: :destroy

  belongs_to :user
  has_and_belongs_to_many :documents
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :events
  has_many :notes

  validates :name, presence: true
  validates :number, presence: true
  validates :case_type, presence: true
  validates :subtype, presence: true
  validates :state, length: { is: 2 }, allow_blank: true
  validates :closing_date, presence: true , if: "self.closed?"
  validates :closing_date, absence: true, if: "self.pending? || self.open?"

  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  
  def self.next_number(case_, action_)
    puts "ACTION NAME " + action_
    if action_ == "index" || action_ == "new"
      Case.maximum(:number).to_i + 1
    else
      case_.number
    end
  end

end
