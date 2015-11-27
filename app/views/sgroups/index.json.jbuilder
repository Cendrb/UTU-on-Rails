json.array!(@sgroups) do |sgroup|
  json.extract! sgroup, :id, :name, :group_category_id
  json.url sgroup_url(sgroup, format: :json)
end
