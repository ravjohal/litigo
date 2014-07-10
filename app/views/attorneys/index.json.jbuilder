json.array!(@attorneys) do |attorney|
  json.extract! attorney, :id, :attorney_type, :firm
  json.url attorney_url(attorney, format: :json)
end
