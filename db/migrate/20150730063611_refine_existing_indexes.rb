class RefineExistingIndexes < ActiveRecord::Migration
  def up
  	# medical_bills
  	remove_index :medical_bills, :user_id
  	remove_index :medical_bills, :parent_id
  	remove_index :medical_bills, :company_id
  	add_index :medical_bills, :parent_id, where: "parent_id <> NULL"
  	add_index :medical_bills, :company_id, where: "company_id <> NULL"

  	# insurances
  	add_index :insurances, :firm_id
  	add_index :insurances, :company_id

  	# contacts
  	remove_index :contacts, :event_id

  	# tasks
  	remove_index :tasks, :parent_id
  end

  def down
  	# medical_bills
  	remove_index :medical_bills, :parent_id
  	remove_index :medical_bills, :company_id
  	add_index :medical_bills, :user_id
  	add_index :medical_bills, :parent_id
  	add_index :medical_bills, :company_id

  	# insurances
  	remove_index :insurances, :firm_id
  	remove_index :insurances, :company_id

  	# contacts
  	add_index :contacts, :event_id

  	# tasks
  	add_index :tasks, :parent_id  	
  end
end
