json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :holiday_beginning, :holiday_end, :school_year_id
  json.url holiday_url(holiday, format: :json)
end
