class CaseSolReport < Dossier::Report
 
  def sql
    Case.where("firm_id = :firm_id AND cast(statute_of_limitations as date) between :start_date and :end_date").select("case_number, name, subtype").to_sql
  end

  def firm_id
	options[:firm_id]
  end

  def start_date
	options[:start_date]
  end

  def end_date
	options[:end_date]
  end

end