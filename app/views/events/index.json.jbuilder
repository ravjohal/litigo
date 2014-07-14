json.array!(@events) do |event|
  json.extract! event, :id, :subject, :location, :date, :time, :all_day, :reminder, :notes
  json.url event_url(event, format: :json)
end
