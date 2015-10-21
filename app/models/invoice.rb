class Invoice < ActiveRecord::Base
  belongs_to :case
  belongs_to :contact
  belongs_to :user
  belongs_to :firm

  STATUS = {:unpaid => 'Unpaid', :unpaid_30 => 'Unpaid 30+', :unpaid_60 => 'Unpaid 60+', :unpaid_90 => 'Unpaid 90+', :paid => 'Paid (full)', :paid_p => 'Paid (partial)', :draft => 'Draft'}

  include PgSearch
  pg_search_scope :search_invoice, against: [:status, :number],
                  using: {tsearch: {dictionary: :english, prefix: true}},
                  associated_against: { :case => [:name], :contact => [:first_name, :last_name]  }


  attr_accessor :add_payment_amount

  after_initialize :after_init
  before_save :calculate_balance

  def self.all_invoices_scope
    all
  end


  def self.increment_number(firm_, action_, invoice)
    return invoice.number if 'edit' == action_.to_s

    new_number = firm_.invoices.maximum(:number).to_i + 1
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

  private

  def after_init
    self.add_payment_amount ||= 0.0
  end

  def calculate_balance
    self.payments += add_payment_amount.to_f if add_payment_amount.to_f > 0
    self.balance = amount - payments if payments_changed?
  end

end
