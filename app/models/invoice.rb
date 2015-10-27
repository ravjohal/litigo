class Invoice < ActiveRecord::Base
  belongs_to :case
  belongs_to :contact
  belongs_to :user
  belongs_to :firm
  has_many :payments
  has_many :expenses
  has_many :time_entries

  STATUS = {:unpaid => 'Unpaid', :unpaid_30 => 'Unpaid 30+', :unpaid_60 => 'Unpaid 60+', :unpaid_90 => 'Unpaid 90+', :paid => 'Paid (full)', :paid_p => 'Paid (partial)', :draft => 'Draft'}

  include PgSearch
  pg_search_scope :search_invoice, against: [:status, :number],
                  using: {tsearch: {dictionary: :english, prefix: true}},
                  associated_against: { :case => [:name], :contact => [:first_name, :last_name]  }


  before_save :calculate_balance
  after_save :save_relations

  attr_accessor :expenses_ids, :time_entries_ids

  def self.all_invoices_scope
    all
  end

  def increment_number
    return number unless new_record?

    new_number = firm.payments.count.to_i + 1
    new_number.to_i
  end

  def self.unpaid_invoices_scope
    where(:status => [:unpaid, :unpaid_30, :unpaid_60, :unpaid_90])
  end

  def self.paid_invoices_scope
    where(:status => [:paid, :paid_p])
  end

  def self.drafts_invoices_scope
    where(status: :draft)
  end

  def safe_status
    self.status ||= :unpaid
  end

  def name
    "# #{number}"
  end

  def recalculate_balance
    sum = payments.sum(:amount)
    self.payment_sum = sum
    update_attribute(:payment_sum, sum)
  end

  private

  def calculate_balance
    self.balance = amount - payment_sum if payment_sum_changed?
  end

  def save_relations

  end

end