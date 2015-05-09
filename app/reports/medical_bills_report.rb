class MedicalBillsReport < Dossier::Report

  def sql
    MedicalBill.where("medical_bills.firm_id = :firm_id
    	AND medical_bills.case_id IN :case_id"
    	).select("company_id, cast(SUM(billed_amount) AS money) AS Billed, cast(SUM(paid_amount) AS money) AS Paid, cast(SUM(billed_amount + paid_amount) AS money) AS Owed"
    	).group(:company_id).to_sql
  end

  def firm_id
	  options[:firm_id]
  end

  def case_id
    options[:case_id_as_criteria]
  end

  def format_header(column_name)
    custom_headers = {
      billed:'Total Billed',
      paid: 'Total Paid',
      owed: 'Total Owed',
      company_id: 'Provider'
    }
    custom_headers.fetch(column_name.to_sym) { super }
  end

  def format_company_id(value)
    Company.find_by_id(value).name if Company.find_by_id(value)
  end

  # def format_owed(value, row)
  #   row[:billed].to_i + row[:paid_amount].to_i
  # end

end

# MedicalBill.where("medical_bills.firm_id = 16 AND medical_bills.case_id = 2942").select("DISTINCT ON (provider) provider, date_of_service, id, SUM(billed_amount) AS Billed, SUM(paid_amount) AS Paid, SUM(billed_amount + paid_amount) AS Owed").group(:provider, :date_of_service, :id)