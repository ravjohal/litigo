json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :middle_name, :last_name, :address, :address_2, :city, :state, :country, :phone_number, :fax_number, :email, :gender, :age, :type
  json.url contact_url(contact, format: :json)
end
