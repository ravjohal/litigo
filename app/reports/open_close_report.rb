class OpenCloseReport < Dossier::Report
	def sql
		Case.joins(:incident).where("CASE 
			WHEN :opened THEN
				cases.firm_id = :firm_id 
	    		AND cast(cases.created_at as date) between :start_date and :end_date
	    	ELSE
	    		cases.firm_id = :firm_id 
	    		AND cast(closing_date as date) between :start_date and :end_date
	    	END"
	    	).group("cases.id, incidents.incident_date"
	    	).select("name, cast(cases.created_at AS date), closing_date, incidents.incident_date, subtype, cases.id as id"
	    	).order("cases.created_at DESC").to_sql
	end

	def format_header(column_name)
	    custom_headers = {
	      id:'Plaintiffs',
	      name: 'Case Name',
	    }
	    custom_headers.fetch(column_name.to_sym) { super }
	  end

	def format_id(value, row)
		contacts_names = ""
		Case.find(value).case_contacts.where(:role => 'Plaintiff').map{
			|case_contact| 
			contacts_names += case_contact.contact.first_name + " " + case_contact.contact.last_name + " "
		}
		contacts_names
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

	def opened
		options[:open_closed] == 'Opened'
	end

	def format_name(value, row)
    	formatter.url_formatter.link_to value, formatter.url_formatter.url_helpers.case_path(row[:id])
  	end
end