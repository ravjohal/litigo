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
                  associated_against: {:case => [:name], :contact => [:first_name, :last_name]}


  before_save :check_issue_status
  before_save :calculate_balance
  before_save :check_status
  after_save :save_relations

  attr_accessor :expenses_ids, :time_entries_ids

  def self.all_invoices_scope
    all
  end

  def draft?
    status.to_s == 'draft'
  end

  def increment_number
    return number unless new_record?

    new_number = firm.invoices.maximum(:number).to_i + 1
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

  def generate_docx(html)
    ImportToDocxService.new("Number-#{number}", html).generate_docx
  end

  private

  def calculate_balance
    self.balance = amount - payment_sum if payment_sum_changed?
    true
  end

  def check_issue_status
    self.issue_date = Time.now if status_changed? && status.to_s == 'unpaid'
    true
  end

  def check_status
    return true if status.to_s == 'draft'
    if amount > 0
      if payment_sum > 0
        self.status = (payment_sum.to_f == amount.to_f && balance == 0) ? :paid : :paid_p
      else
        if Time.now <= (due_date + 30.days)
          self.status = :unpaid
        elsif Time.now > (due_date + 30.days) && Time.now <= (due_date + 60.days)
          self.status = :unpaid_30
        elsif Time.now > (due_date + 60.days) && Time.now <= (due_date + 90.days)
          self.status = :unpaid_60
        elsif Time.now > (due_date + 90.days)
          self.status = :unpaid_90
        end
      end
    end
    true
  end

  def save_relations
    Expense.where(id: expenses_ids).update_all(invoice_id: id) if expenses_ids
    TimeEntry.where(id: time_entries_ids).update_all(invoice_id: id) if time_entries_ids
  end

end