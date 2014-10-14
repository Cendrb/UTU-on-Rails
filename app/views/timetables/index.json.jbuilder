json.array!(@timetables) do |timetable|
  json.extract! timetable, :id, :string
  json.url timetable_url(timetable, format: :json)
end
