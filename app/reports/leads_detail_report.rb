class LeadsDetailReport < Dossier::Report
	def sql
		Lead.where("marketing_channel = :marketing_channel_arg AND cast(created_at as date) between :start_date and :end_date").select("marketing_channel, first_name, last_name, created_at, sub_type, estimated_value").to_sql
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