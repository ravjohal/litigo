class CasesByUserReport < Dossier::Report

  def sql
    Case.joins(:case_contacts => :contact).where("cases.firm_id = :firm_id 
      AND role IN ('Attorney', 'Staff')
      AND user_account_id IN :user_contact_id"
      ).select("last_name, first_name, case_number, name, subtype, status"
      ).uniq.to_sql
  end

  def firm_id
	  options[:firm_id]
  end

  def user_contact_id
    User.find(options[:user_contact_id])
  end

end