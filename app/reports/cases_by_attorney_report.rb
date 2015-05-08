class CasesByAttorneyReport < Dossier::Report

  def sql
    Case.joins(:contacts).where("cases.firm_id = :firm_id 
      AND type IN ('Attorney', 'Staff')
      AND contacts.id IN :attorney_contact_id"
      ).select("last_name, first_name, case_number, name, subtype, status"
      ).to_sql
  end

  def firm_id
	  options[:firm_id]
  end

  def attorney_contact_id
    options[:attorney_contact_id]
  end

end