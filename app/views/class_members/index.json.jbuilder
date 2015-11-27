json.array!(@class_members) do |class_member|
  json.extract! class_member, :id, :first_name, :last_name, :sclass_id
  json.url class_member_url(class_member, format: :json)
end
