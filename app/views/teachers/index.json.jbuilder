json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :name, :description, :group
  json.url teacher_url(teacher, format: :json)
end
