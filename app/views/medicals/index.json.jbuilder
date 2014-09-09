json.array!(@medicals) do |medical|
  json.extract! medical, :id, :total_med_bills, :subrogated_amount, :injuries_within_three_days, :length_of_treatment, :length_of_treatment, :doctor_type, :treatment_type
  json.url medical_url(medical, format: :json)
end
