json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :description, :subject, :date, :group
  json.url task_url(task, format: :json)
end
