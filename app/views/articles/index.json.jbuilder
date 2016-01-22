json.array!(@articles) do |article|
  json.extract! article, :id, :title, :text, :published, :sclass_id, :sgroup_id, :show_in_details_until
  json.url article_url(article, format: :json)
end
