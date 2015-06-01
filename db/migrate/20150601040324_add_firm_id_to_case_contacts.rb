class AddFirmIdToCaseContacts < ActiveRecord::Migration
  def change
    add_column :case_contacts, :firm_id, :integer

    CaseContact.all.each do |case_con|
    	if case_con.contact
    		firm_ = case_con.contact.firm
    		case_con.firm = firm_
    		case_con.save!
    	end
    end
  end
end
