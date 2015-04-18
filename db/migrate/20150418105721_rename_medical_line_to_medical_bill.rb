class RenameMedicalLineToMedicalBill < ActiveRecord::Migration
	def change
    	rename_table :medical_lines, :medical_bills
  	end 
end
