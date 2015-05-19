class AddCompanyIdToInsurances < ActiveRecord::Migration
  def change
    add_column :insurances, :company_id, :integer
  end
end
