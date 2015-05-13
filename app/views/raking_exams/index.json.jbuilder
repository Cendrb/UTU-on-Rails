json.array!(@rakings) do |raking|
  json.extract! raking, :id, :end, :subject_id, :name, :description
  json.url raking_url(raking, format: :json)
end
