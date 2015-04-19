class CaseSolReport < Dossier::Report
 
  def sql
    Case.where().to_sql
  end

  def start_date

  end

  def end_date

  end

end