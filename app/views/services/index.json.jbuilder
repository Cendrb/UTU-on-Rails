json.array!(@services) do |service|
  json.extract! service, :id, :first_name, :second_name, :service_start, :service_end
  json.url service_url(service, format: :json)
end
