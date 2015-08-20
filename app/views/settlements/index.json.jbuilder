json.array!(@settlements) do |settlement|
  json.extract! settlement, :id
  json.url settlement_url(settlement, format: :json)
end
