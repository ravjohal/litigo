json.array!(@staffs) do |staff|
  json.extract! staff, :id, :staff_type
  json.url staff_url(staff, format: :json)
end
