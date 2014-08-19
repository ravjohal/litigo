json.array!(@firms) do |firm|
  json.extract! firm, :id, :name, :address, :phone, :fax
  json.url firm_url(firm, format: :json)
end
