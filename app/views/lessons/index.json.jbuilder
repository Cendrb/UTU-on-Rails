json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :subject, :room, :teacher
  json.url lesson_url(lesson, format: :json)
end
