class CaseSolReport < Dossier::Report
 #@my_notes = @notes.joins(:case => [{:contacts => :user}]).where(:contacts => {:user_account_id => @user.id})

# ABOVE NOTATION TRANSLATES TO EXACT SQL:

 # SELECT "notes".* FROM "notes" 
 # INNER JOIN "cases" ON "cases"."id" = "notes"."case_id" 
 # INNER JOIN "case_contacts" ON "case_contacts"."case_id" = "cases"."id" 
 # INNER JOIN "contacts" ON "contacts"."id" = "case_contacts"."contact_id" 
 # INNER JOIN "users" ON "users"."id" = "contacts"."user_id" 
 # WHERE "notes"."firm_id" = $1 AND "contacts"."user_account_id" = 23

  def sql
    Case.joins(:case_contacts, :incident).where("CASE
      WHEN :dates_given THEN
        cases.firm_id = :firm_id 
      	AND case_contacts.role IN ('Attorney', 'Staff')
      	AND case_contacts.contact_id IN :attorney_contact_id
        AND cases.status NOT IN ('Pending Close', 'Closed')
      	AND cast(statute_of_limitations as date) between :start_date and :end_date
      ELSE 
        cases.firm_id = :firm_id 
        AND case_contacts.role IN ('Attorney', 'Staff')
        AND case_contacts.contact_id IN :attorney_contact_id
        AND cases.status NOT IN ('Pending Close', 'Closed')
      END"
    	).group("cases.id").select("case_number, name, subtype, statute_of_limitations, filed_suit_date"
    	).to_sql

 # SELECT case_number, name, subtype, first_name, last_name, incident_date, statute_of_limitations, filed_suit_date 
 # FROM "cases" INNER JOIN "case_contacts" ON "case_contacts"."case_id" = "cases"."id" 
 # INNER JOIN "contacts" ON "contacts"."id" = "case_contacts"."contact_id" 
 # INNER JOIN "incidents" ON "incidents"."case_id" = "cases"."id" 
 # WHERE (cases.firm_id = 16 
 #   	AND type IN ('Attorney', 'Staff')
 #   	AND contacts.id = '1874' 
 #   	AND cast(statute_of_limitations as date) between '2015-04-01' and '2015-04-30')
  end

  def format_header(column_name)
    custom_headers = {
      name:'Case Name',
    }
    custom_headers.fetch(column_name.to_sym) { super }
  end

  def format_case_number(value, row)
    formatter.url_formatter.link_to value, formatter.url_formatter.url_helpers.case_path(:id => Case.find_by(:case_number => value, :firm_id => firm_id))
  end

  def firm_id
	  options[:firm_id]
  end

  def dates_given
    if options[:start_date] == '' && options[:end_date] == ''
      false
    else
      true
    end
  end

  def start_date
  	if options[:start_date] == ''
  		'0001-01-01'
  	else
  		options[:start_date]
  	end
  end

  def end_date
  	if options[:end_date] == ''
  		'3000-01-01'
  	else
  		options[:end_date]
  	end
  end

  def attorney_contact_id
    options[:attorney_contact_id]
  end

end