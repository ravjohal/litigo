class LeadsByChannelReport < Dossier::Report
	def sql
		Lead.where("created_at between :start_date and :end_date").to_sql
	end

	def start_date
		options[:start_date]
	end

	def end_date
		options[:end_date]
	end
end