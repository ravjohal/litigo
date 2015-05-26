class RenameCompanyToCompanyOld < ActiveRecord::Migration
  def change
  	rename_table :companies, :company_olds
  end
end
