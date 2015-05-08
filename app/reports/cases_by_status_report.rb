class CasesByStatusReport < Dossier::Report

  def sql
    "SELECT status, name, subtype
    FROM cases
    WHERE status = :selected_case_status"
  end

  def firm_id
	  options[:firm_id]
  end

  def attorney_contact_id
    options[:attorney_contact_id]
  end

end