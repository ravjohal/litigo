json.array!(@namespaces) do |namespace|
  json.extract! namespace, :id
  json.url namespace_url(namespace, format: :json)
end
