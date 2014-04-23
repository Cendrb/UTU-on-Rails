json.array!(@users) do |user|
  json.extract! user, :id, :email, :hashed_password, :salt, :admin, :group
  json.url user_url(user, format: :json)
end
