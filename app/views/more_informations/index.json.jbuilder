json.array!(@more_informations) do |more_information|
  json.extract! more_information, :id, :name, :url
  json.url more_information_url(more_information, format: :json)
end
