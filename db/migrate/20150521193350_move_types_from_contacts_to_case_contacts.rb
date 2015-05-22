class MoveTypesFromContactsToCaseContacts < ActiveRecord::Migration
  def change
    CaseContact.reset_column_information
    CaseContact.all.each do |case_contact|
      case_contact.role = case_contact.contact.type.to_s if case_contact.contact.type.present?
      case_contact.save
    end
  end
end
