json.array!(@planned_raking_lists) do |planned_raking_list|
  json.extract! planned_raking_list, :id, :title, :description, :subject_id, :beginning
  json.url planned_raking_list_url(planned_raking_list, format: :json)
end
