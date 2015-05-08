class LeadsDetailReport < Dossier::Report
	def sql
		Lead.where("firm_id = :firm_id AND marketing_channel IN :marketing_channel_arg AND cast(created_at as date) between :start_date and :end_date").select("marketing_channel, first_name, last_name, cast(created_at AS date), sub_type, cast(estimated_value AS money)").to_sql
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

	def marketing_channel_arg
		options[:marketing_channel_arg]
	end
end