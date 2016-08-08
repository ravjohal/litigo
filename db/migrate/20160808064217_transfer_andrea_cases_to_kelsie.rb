class TransferAndreaCasesToKelsie < ActiveRecord::Migration
  def up
  	user_source = User.find_by_email("aroberts@tsmslaw.com")
  	user_target = User.find_by_email("kthomas@tsmslaw.com")

  	contact_source = Contact.find_by_email("aroberts@tsmslaw.com")
  	contact_target = Contact.find_by_email("kthomas@tsmslaw.com")

 #  	if user_source
	#   	user_source.cases.each do |case_|
	#   		case_.user = user_target
	#   		case_.save!
	#   	end
	# end

	if contact_source
		contact_source.case_contacts.each do |cc|
			cc_new = CaseContact.new
			cc_new.affair = cc.affair
			cc_new.role = cc.role
			cc_new.firm = cc.firm
			cc_new.note = cc.note
			cc_new.contact = contact_target
			cc_new.save!
		end
	end
  end

  def down
  	user_source = User.find_by_email("kthomas@tsmslaw.com")
  	user_target = User.find_by_email("aroberts@tsmslaw.com")

  	contact_source = Contact.find_by_email("kthomas@tsmslaw.com")
  	contact_target = Contact.find_by_email("aroberts@tsmslaw.com")
  	
 #  	if user_source
	#   	user_source.cases.each do |case_|
	#   		case_.user = user_target
	#   		case_.save!
	#   	end
	# end

	if contact_source
		contact_source.case_contacts.delete_all
	end
  end
end
