json.array!(@documents) do |document|
  json.extract! document, :id, :author, :type, :template
  json.url document_url(document, format: :json)
end
