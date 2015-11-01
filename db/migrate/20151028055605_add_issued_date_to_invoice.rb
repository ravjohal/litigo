class AddIssuedDateToInvoice < ActiveRecord::Migration

  def up
    add_column :invoices, :issue_date, :datetime
  end

  def down
    remove_column :invoices, :issue_date
  end

end
