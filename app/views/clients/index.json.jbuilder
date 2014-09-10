json.array!(@clients) do |client|
  json.id  client.id
  json.name client.full_name
end
