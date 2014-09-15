json.array!(@bitches) do |bitch|
  json.extract! bitch, :id, :name, :description, :group
  json.url bitch_url(bitch, format: :json)
end
