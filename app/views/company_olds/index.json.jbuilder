json.array!(@companies) do |company|
  json.extract! company, :id, :name, :address, :phone, :fax, :state, :city, :zipcode, :website
  json.url company_url(company, format: :json)
end
