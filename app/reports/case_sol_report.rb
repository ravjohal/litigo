class CaseSolReport < Dossier::Report
 
  def sql
    Case.where("").select("number, name, sub_type, ").to_sql
  end

  def start_date

  end

  def end_date

  end

end