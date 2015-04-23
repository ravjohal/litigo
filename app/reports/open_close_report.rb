class OpenCloseReport < Dossier::Report
	def sql
		"SELECT 
    	sum(case when created_at >= :start_date AND firm_id = :firm_id then 1 else 0 end)AS Cases_Opened,
    	sum(case when closing_date <= :end_date AND firm_id = :firm_id then 1 else 0 end) AS Cases_Closed
		FROM cases"
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