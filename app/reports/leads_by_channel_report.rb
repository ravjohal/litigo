class LeadsByChannelReport < Dossier::Report
	# set_callback :execute,     :after do
	#   mangle_results
	# end

	def sql
		Lead.where("created_at between :start_date and :end_date").select("marketing_channel, count(*) as Leads").group(:marketing_channel).to_sql
	end

	def format_header(column_name)
	    custom_headers = {
	      leads:   'Number of Leads'
	    }
	    custom_headers.fetch(column_name.to_sym) { super }
  	end

  	# The following two methods are used for when requesting what columns to return (if used as argument)
	# def columns
 #    	valid_columns.join(', ').presence || '*'
 #  	end
  	
 #  	def valid_columns
 #    	self.class.valid_columns & Array.wrap(options[:columns])
 #  	end

  	def format_leads(value, row)
  		formatter.url_formatter.link_to value, formatter.url_formatter.url_helpers.report_show_path(row[:marketing_channel])
  	end

	def start_date
		options[:start_date]
	end

	def end_date
		options[:end_date]
	end
end