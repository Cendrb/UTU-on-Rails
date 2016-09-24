json.array!(@seminars) do |seminar|
  json.extract! seminar, :id, :name, :subject_id
  json.url seminar_url(seminar, format: :json)
end
