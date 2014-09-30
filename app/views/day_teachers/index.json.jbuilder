json.array!(@day_teachers) do |day_teacher|
  json.extract! day_teacher, :id, :date, :teacher_id
  json.url day_teacher_url(day_teacher, format: :json)
end
