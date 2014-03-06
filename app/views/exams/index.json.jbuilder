json.array!(@exams) do |exam|
  json.extract! exam, :id, :title, :description, :subject, :date, :group
  json.url exam_url(exam, format: :json)
end
