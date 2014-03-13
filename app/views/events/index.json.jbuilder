json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :location, :event_start, :event_end
  json.url event_url(event, format: :json)
end
