class CasesByStatusReport < Dossier::Report

  def sql
    Case.where("firm_id = :firm_id AND status IN :case_status_arg").select("status, case_number, name, cast(created_at AS date)").to_sql
  end

  def firm_id
	  options[:firm_id]
  end

  def case_status_arg
    options[:case_status_arg]
  end

end