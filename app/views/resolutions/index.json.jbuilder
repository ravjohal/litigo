json.array!(@resolutions) do |resolution|
  json.extract! resolution, :id, :case_id, :firm_id, :settlement_demand, :jury_demand, :resolution_amount, :resolution_type
  json.url resolution_url(resolution, format: :json)
end
