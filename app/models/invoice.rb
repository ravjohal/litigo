class Invoice < ActiveRecord::Base
  belongs_to :case
  belongs_to :contact

  before_save :calculate_balance

  private
  def calculate_balance
    self.balance = amount - payments if payments_changed?
  end

end
