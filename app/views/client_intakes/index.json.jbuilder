json.array!(@client_intakes) do |client_intake|
  json.extract! client_intake, :id
  json.url client_intake_url(client_intake, format: :json)
end
