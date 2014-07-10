json.array!(@plantiffs) do |plantiff|
  json.extract! plantiff, :id, :married, :employed, :job_description, :salary, :parent, :felony_convictions, :last_ten_years, :jury_likeability
  json.url plantiff_url(plantiff, format: :json)
end
