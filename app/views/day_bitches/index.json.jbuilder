json.array!(@day_bitches) do |day_bitch|
  json.extract! day_bitch, :id, :date, :bitch_id
  json.url day_bitch_url(day_bitch, format: :json)
end
