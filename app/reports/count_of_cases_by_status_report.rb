class CountOfCasesByStatusReport < Dossier::Report

  def sql
    # OLD: Case.where("firm_id = :firm_id").select("status, count(status)").group("status").to_sql

    "SELECT status, count(status) FROM cases JOIN (
    	VALUES 
    	('Active', 1), 
    	('Treating', 2), 
    	('Done Treating', 3), 
    	('Finals Requested', 4),
    	('Settlement Package Out', 5),
    	('Negotiation', 6),
    	('Litigation', 7),
    	('Pending Close', 8),
    	('Closed', 9),
    	('Appeal', 10),
    	('Inactive', 11)
    	) as x (st, ordering) on cases.status = x.st WHERE firm_id = :firm_id GROUP BY x.ordering, status ORDER BY x.ordering"
  end

  def firm_id
	options[:firm_id]
  end

  def format_count(value, row)
  	formatter.url_formatter.link_to value, formatter.url_formatter.url_helpers.reports_cases_by_status_path(:case_status_arg => row[:status])
  end

end