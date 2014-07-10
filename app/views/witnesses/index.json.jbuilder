json.array!(@witnesses) do |witness|
  json.extract! witness, :id, :witness_type, :witness_subtype, :witness_doctype
  json.url witness_url(witness, format: :json)
end
