json.array!(@treatments) do |treatment|
  json.extract! treatment, :id, :injury_id, :firm_id, :surgery, :surgery_count, :surgery_type, :casted_fracture, :stitches, :future_surgery, :future_medicals
  json.url treatment_url(treatment, format: :json)
end
