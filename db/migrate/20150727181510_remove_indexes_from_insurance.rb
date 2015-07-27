class RemoveIndexesFromInsurance < ActiveRecord::Migration
  def change
    remove_index :insurances, :firm_id
    remove_index :insurances, :case_id
    remove_index :insurances, :company_id
    remove_index :insurances, :insurance_provider
  end
end
