class MoveTypesFromContactsToCaseContacts < ActiveRecord::Migration
  def change
    CaseContact.reset_column_information
    CaseContact.all.each do |case_contact|
      case_contact.role = case_contact.contact.type.to_s
      case_contact.save
    end
  end
end
