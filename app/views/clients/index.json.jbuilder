json.array!(clients) do |client|
  json.id client.id
  json.name client.full_name
  json.url client_url(client, format: :json)
end
