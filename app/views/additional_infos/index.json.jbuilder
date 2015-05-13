json.array!(@additional_infos) do |additional_info|
  json.extract! additional_info, :id, :name, :url, :task_id, :exam_id, :raking_id, :event_id
  json.url additional_info_url(additional_info, format: :json)
end
