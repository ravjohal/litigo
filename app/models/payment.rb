class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :firm
  belongs_to :user

  after_create :recalculate_invoice_balance

  include PgSearch
  pg_search_scope :search_payment, against: [:number, :amount, :date, :comment],
                  using: {tsearch: {dictionary: :english, prefix: true}}

  def increment_number
    return number unless new_record?

    new_number = invoice.payments.maximum(:number).to_i + 1
    new_number.to_i
  end

  private
  def recalculate_invoice_balance
    invoice.recalculate_balance if invoice
  end
end
