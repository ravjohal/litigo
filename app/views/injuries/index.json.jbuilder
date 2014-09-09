json.array!(@injuries) do |injury|
  json.extract! injury, :id, :type, :region, :code
  json.url injury_url(injury, format: :json)
end
