class AddAmountPaidToInsurance < ActiveRecord::Migration
  def change
    add_column :insurances, :amount_paid, :decimal
  end
end
