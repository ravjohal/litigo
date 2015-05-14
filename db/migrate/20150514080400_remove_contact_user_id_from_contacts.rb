class RemoveContactUserIdFromContacts < ActiveRecord::Migration
  def up
  	Contact.all.each do |contact|
  		contact.user_account_id = contact.contact_user_id if contact.contact_user_id
  		contact.save!
  	end
    remove_column :contacts, :contact_user_id, :integer
  end

  def down
  	add_column :contacts, :contact_user_id, :integer
  	Contact.all.each do |contact|
  		contact.contact_user_id = contact.user_account_id if contact.user_account_id
  		contact.save!
  	end
  end
end
