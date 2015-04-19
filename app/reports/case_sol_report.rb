class CaseSolReport < Dossier::Report
 #@my_notes = @notes.joins(:case => [{:contacts => :user}]).where(:contacts => {:contact_user_id => @user.id})
  def sql
    Case.where("firm_id = :firm_id AND cast(statute_of_limitations as date) between :start_date and :end_date").select("case_number, name, subtype").to_sql
  end

  def firm_id
	options[:firm_id]
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

end