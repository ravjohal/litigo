class CountOfCasesByStatusReport < Dossier::Report

  def sql
    Case.where("firm_id = :firm_id").select("status, count(status)").group("status").to_sql
  end

  def firm_id
	options[:firm_id]
  end

  def format_count(value, row)
  	formatter.url_formatter.link_to value, formatter.url_formatter.url_helpers.reports_cases_by_status_path(:case_status_arg => row[:status])
  end

end