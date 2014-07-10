json.array!(@defendants) do |defendant|
  json.extract! defendant, :id, :married, :employed, :job_description, :salary, :parent, :felony_convictions, :last_ten_years, :jury_likeability
  json.url defendant_url(defendant, format: :json)
end
