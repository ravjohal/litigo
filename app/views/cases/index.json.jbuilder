json.array!(@cases) do |case|
  json.extract! case, :id, :name, :number, :description, :medical_bills
  json.url case_url(case, format: :json)
end
