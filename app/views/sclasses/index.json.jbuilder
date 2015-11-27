json.array!(@sclasses) do |sclass|
  json.extract! sclass, :id, :name
  json.url sclass_url(sclass, format: :json)
end
