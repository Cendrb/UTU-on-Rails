json.array!(@written_exams) do |written_exam|
  json.extract! written_exam, :id
  json.url written_exam_url(written_exam, format: :json)
end
