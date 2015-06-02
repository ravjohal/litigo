class MoveCompanyOldDataToNewCompany < ActiveRecord::Migration
  def change
    # create_table :companies do |t|
    #   CompanyOld.columns.each do |column|
    #     next if column.name == "id"   # already created by create_table
    #     t.send(column.type.to_sym, column.name.to_sym,  :null => column.null, 
    #       :limit => column.limit, :default => column.default, :scale => column.scale,
    #       :precision => column.precision)
    #   end
    # end

    # copy data 

    CompanyOld.all.each do |m|
      company = Company.new m.attributes.slice(Company.attribute_names)
      company.company_name = m.name
      company.zip_code = m.zipcode
      company.phone_number = m.phone
      company.phone_number_1 = m.phone_1
      company.phone_number_2 = m.phone_2
      company.fax_number = m.fax
      company.fax_number_1 = m.fax_1
      company.fax_number_2 = m.fax_2
      company.firm_id = m.firm_id
      company.website = m.website
      company.user_id = m.user_id
      company.city = m.city
      company.state = m.state
      company.address = m.address
      company.save!
      # company.medical_bills = m.medical_bills
      MedicalBill.all.each do |med|
      	med.update_attribute(:company_id, company.id) if med.company_id == m.id
      end
      # company.insurances = m.insurances
      Insurance.all.each do |ins|
        ins.update_attribute(:company_id, company.id) if ins.company_id == m.id
      end
      # company.contacts = m.contacts
      Contact.all.each do |contact| 
      	contact.update_attribute(:company_id, company.id) if contact.company_id == m.id
      end
    end
  end
end
