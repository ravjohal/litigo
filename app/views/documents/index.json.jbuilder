json.array!(@documents) do |document|
  json.extract! document, :id, :author, :doc_type, :template
  json.url document_url(document, format: :json)
end
