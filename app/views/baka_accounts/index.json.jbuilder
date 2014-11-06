json.array!(@baka_accounts) do |baka_account|
  json.extract! baka_account, :id, :username, :password
  json.url baka_account_url(baka_account, format: :json)
end
