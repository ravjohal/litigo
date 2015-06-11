class MoveOtherPhonesToPhoneModel < ActiveRecord::Migration
  def change
  	Contact.all.each do |contact|
  		phone_other_1 = Phone.create(label: "Other Phone 1", number: contact.phone_number_1, contact_id: contact.id, firm_id: contact.firm_id) if (contact.phone_number_1 && contact.phone_number_1 != "")
  		phone_other_2 = Phone.create(label: "Other Phone 2", number: contact.phone_number_2, contact_id: contact.id, firm_id: contact.firm_id) if (contact.phone_number_2 && contact.phone_number_2 != "")
  		fax_other_1 = Phone.create(label: "Other Fax 1", number: contact.fax_number_1, contact_id: contact.id, firm_id: contact.firm_id) if (contact.fax_number_1 && contact.fax_number_1 != "")
  		fax_other_2 = Phone.create(label: "Other Fax 2", number: contact.fax_number_2, contact_id: contact.id, firm_id: contact.firm_id) if (contact.fax_number_2 && contact.fax_number_2 != "")
  		p phone_other_1.inspect + " ---- " + phone_other_2.inspect + " ----- " + fax_other_1.inspect + " ------ " + fax_other_2.inspect
  	end
  end
end