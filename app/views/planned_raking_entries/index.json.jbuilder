json.array!(@planned_raking_entries) do |planned_raking_entry|
  json.extract! planned_raking_entry, :id, :name, :planned_raking_list_id, :user_id, :finished, :sorting_order
  json.url planned_raking_entry_url(planned_raking_entry, format: :json)
end
