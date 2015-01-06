json.array!(@details_accesses) do |details_access|
  json.extract! details_access, :id, :user_id, :ip_address, :user_agent
  json.url details_access_url(details_access, format: :json)
end
